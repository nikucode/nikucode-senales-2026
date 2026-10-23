// Offline headless evidence. This does not test an operating-system notice,
// pointer gestures, a real phone, accessibility services, or physical movement.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nikucode_senales/main.dart';
import 'package:nikucode_senales/pause_view_model.dart';
import 'package:nikucode_senales/reminder_channel.dart';

class _EvidenceBinding extends WidgetsFlutterBinding {
  Size viewport = const Size(1200, 900);

  @override
  ViewConfiguration createViewConfigurationFor(RenderView renderView) =>
      ViewConfiguration(
        logicalConstraints: BoxConstraints.tight(viewport),
        physicalConstraints: BoxConstraints.tight(viewport),
        devicePixelRatio: 1,
      );
}

class _FakeChannel extends ReminderChannel {
  bool permission = true;
  final shown = <int>[];
  int cancellations = 0;
  bool disposed = false;
  void Function(int)? callback;

  @override
  bool get supported => true;
  @override
  String get scopeLabel => 'Canal simulado para evidencia headless';
  @override
  set onOpen(void Function(int)? value) => callback = value;
  @override
  Future<bool> requestPermission() async => permission;
  @override
  Future<void> show(int id) async => shown.add(id);
  @override
  Future<void> cancel() async => cancellations++;
  @override
  void dispose() => disposed = true;
}

Future<void> main() async {
  final output = Directory('build/checkpoint_evidence')
    ..createSync(recursive: true);
  final binding = _EvidenceBinding();
  final errors = <String>[];
  final checks = <String>[];
  final captures = <String>[];
  FlutterError.onError = (details) {
    errors.add(details.exceptionAsString());
    stderr.writeln(details.exceptionAsString());
  };
  final channel = _FakeChannel();
  final model = PauseViewModel(channel: channel);
  final boundaryKey = GlobalKey();
  final textScale = ValueNotifier<TextScaler>(TextScaler.noScaling);
  double? observedLargeTextScale;

  void check(bool condition, String description) {
    if (!condition) throw StateError(description);
    checks.add(description);
  }

  Future<void> frame() async {
    binding.scheduleFrame();
    await binding.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 30));
  }

  Set<String> renderedText() {
    final text = <String>{};
    void collect(Element element) {
      final widget = element.widget;
      if (widget is Text && widget.data != null) text.add(widget.data!);
      element.visitChildElements(collect);
    }

    collect(boundaryKey.currentContext! as Element);
    return text;
  }

  Future<void> capture(String name, Size size) async {
    binding.viewport = size;
    binding.handleMetricsChanged();
    await Future<void>.delayed(const Duration(milliseconds: 300));
    await frame();
    final boundary =
        boundaryKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) throw StateError('No PNG data for $name');
    File('${output.path}/$name.png')
        .writeAsBytesSync(bytes.buffer.asUint8List());
    image.dispose();
    captures.add(name);
  }

  try {
    runApp(
      RepaintBoundary(
        key: boundaryKey,
        child: ValueListenableBuilder<TextScaler>(
          valueListenable: textScale,
          child: PauseApp(viewModel: model),
          builder: (context, scaler, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: scaler),
            child: child!,
          ),
        ),
      ),
    );
    await frame();
    check(renderedText().contains('Ver una pausa'), 'home action rendered');
    await capture('desktop_home', const Size(1200, 900));
    await capture('mobile_home', const Size(390, 1200));
    textScale.value = TextScaler.linear(2);
    await capture('mobile_home_200_percent', const Size(390, 844));
    void findLargeText(Element element) {
      if (element.widget case RichText(:final text)) {
        if (text.toPlainText() == 'Ver una pausa') {
          final render = element.findRenderObject();
          if (render is RenderParagraph) {
            observedLargeTextScale = render.textScaler.scale(16) / 16;
          }
        }
      }
      element.visitChildElements(findLargeText);
    }

    findLargeText(boundaryKey.currentContext! as Element);
    check(
      observedLargeTextScale == 2,
      '390x844 large text is rendered at 200 percent',
    );
    check(!channel.disposed, 'changing text scale preserves the view model');
    textScale.value = TextScaler.noScaling;
    await frame();

    await model.scheduleReminder(const Duration(milliseconds: 20));
    check(!model.hasPendingReminder, 'disabled reminders do not schedule');
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(milliseconds: 20));
    await Future<void>.delayed(const Duration(milliseconds: 80));
    check(channel.shown.length == 1, 'in-process timer calls fake channel');
    check(!model.hasPendingReminder, 'delivered invitation no longer pending');
    channel.callback!(channel.shown.single);
    await frame();
    check(
      model.stage == PauseStage.proposal,
      'valid delivered action opens proposal',
    );
    check(renderedText().contains('Empezar'), 'proposal action rendered');
    check(
      renderedText().contains('Caminar un momento') &&
          renderedText().contains('Ahora no') &&
          !renderedText().contains('nikucode · pausa'),
      'proposal keeps a clear way to decline',
    );
    textScale.value = TextScaler.linear(2);
    await capture('mobile_proposal_200_percent', const Size(390, 844));
    textScale.value = TextScaler.noScaling;
    await frame();
    await capture('mobile_proposal', const Size(390, 1200));
    await capture('desktop_proposal', const Size(1200, 900));
    model.changeProposal();
    check(
      model.proposal.title == 'Tu movimiento habitual',
      'alternative proposal available',
    );
    model.startGuide();
    await frame();
    check(renderedText().contains('Cerrar guía'), 'guide controls rendered');
    await capture('desktop_guide', const Size(1200, 900));
    model.finishGuide();
    await frame();
    check(
      renderedText().contains('Espacio hecho'),
      'guide closure distinguished',
    );
    await capture('desktop_finished', const Size(1200, 900));

    model.goHome();
    await model.scheduleReminder(const Duration(milliseconds: 20));
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final staleId = channel.shown.last;
    final deliveredCount = channel.shown.length;
    await model.scheduleReminder(const Duration(milliseconds: 100));
    model.openFromReminder(staleId);
    check(model.stage == PauseStage.home, 'replaced action is ignored');
    model.openProposal();
    model.dismissProposal();
    await Future<void>.delayed(const Duration(milliseconds: 150));
    check(
      channel.shown.length == deliveredCount,
      'manual opening cancels pending delivery',
    );
    check(
      model.stage == PauseStage.home,
      'reject returns without restoring invitation',
    );

    model.openProposal();
    model.startGuide();
    model.stopGuide();
    check(model.stage == PauseStage.stopped, 'stop is distinct from finish');
    model.goHome();
    await model.scheduleReminder(const Duration(milliseconds: 100));
    await model.setRemindersEnabled(false);
    await Future<void>.delayed(const Duration(milliseconds: 150));
    check(
      channel.shown.length == deliveredCount,
      'disable cancels pending timer',
    );
    channel.permission = false;
    await model.setRemindersEnabled(true);
    check(!model.remindersEnabled, 'permission denial leaves channel disabled');

    runApp(const SizedBox.shrink());
    await frame();
    check(channel.disposed, 'app disposal closes channel');
    textScale.dispose();
    check(errors.isEmpty, 'no Flutter rendering errors reported');
    File('${output.path}/result.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert({
        'passed': true,
        'checks': checks,
        'captures': captures,
        'large_text': {
          'viewport_width': 390,
          'viewport_height': 844,
          'observed_render_paragraph_scale': observedLargeTextScale,
        },
        'render_errors': errors,
        'limits': [
          'fake notification transport; no operating-system delivery verified',
          'headless rendering at viewport sizes; no physical phone tested',
          'model-driven transitions, not pointer/keyboard interaction tests',
          'no measurement of bodily movement or behavioural effect',
        ],
      }),
    );
    stdout.writeln(
      'CHECKPOINT_SMOKE_PASS ${checks.length} checks, ${captures.length} captures',
    );
    exit(0);
  } catch (error, stack) {
    File('${output.path}/result.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert({
        'passed': false,
        'completed_checks': checks,
        'captures': captures,
        'render_errors': errors,
        'error': error.toString(),
        'stack': stack.toString(),
      }),
    );
    stderr.writeln('CHECKPOINT_SMOKE_FAIL $error');
    exit(1);
  }
}
