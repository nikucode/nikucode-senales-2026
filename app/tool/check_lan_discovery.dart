import 'dart:io';

import 'package:nikucode_senales/lan_discovery.dart';

void check(bool condition, String message) {
  if (!condition) throw StateError(message);
}

void main() {
  const id = '0123456789abcdef0123456789abcdef';
  const nonce = 'abcdef0123456789abcdef0123456789';
  const lines =
      '''
=;wlan0;IPv4;nikucode-pausa;_nikucode-pause._tcp;local;phone.local;192.168.1.8;0;
=;wlan0;IPv4;nikucode-pausa;_nikucode-pause._tcp;local;phone.local;192.168.1.8;46274;
=;wlan0;IPv4;nikucode-pausa-2;_nikucode-pause._tcp;local;phone.local;192.168.1.9;46275;"target=$id" "nonce=$nonce"
''';
  final paired = parseLanAnnouncement(lines);
  check(
    paired?.address == '192.168.1.8' && paired?.port == 46274,
    'La reconexión debe aceptar el puerto anunciado.',
  );
  final requested = parseLanAnnouncement(lines, requiredTarget: id);
  check(
    requested?.address == '192.168.1.9' &&
        requested?.port == 46275 &&
        requested?.nonce == nonce,
    'La solicitud debe coincidir con el computador elegido.',
  );
  check(
    parseLanAnnouncement(
          lines,
          requiredTarget: 'ffffffffffffffffffffffffffffffff',
        ) ==
        null,
    'No se debe aceptar la solicitud de otro computador.',
  );
  stdout.writeln('Descubrimiento LAN: casos correctos');
}
