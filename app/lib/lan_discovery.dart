import 'dart:io';

typedef LanAnnouncement = ({
  String address,
  int port,
  String? target,
  String? nonce,
});

/// Avahi's parsable resolved records for the Android pause service.
LanAnnouncement? parseLanAnnouncement(String output, {String? requiredTarget}) {
  for (final line in output.split('\n')) {
    final fields = line.split(';');
    if (fields.length <= 8 ||
        fields.first != '=' ||
        fields[2] != 'IPv4' ||
        !fields[3].startsWith('nikucode-pausa')) {
      continue;
    }
    final address = fields[7];
    final port = int.tryParse(fields[8]);
    if (InternetAddress.tryParse(address)?.type != InternetAddressType.IPv4 ||
        port == null ||
        port < 1 ||
        port > 65535) {
      continue;
    }
    String? attribute(String name) {
      for (final value
          in fields
              .skip(9)
              .join(';')
              .replaceAll('"', '')
              .split(RegExp(r'[;\s]+'))) {
        if (value.startsWith('$name=')) {
          return value.substring(name.length + 1);
        }
      }
      return null;
    }

    final target = attribute('target');
    final nonce = attribute('nonce');
    if (requiredTarget != null &&
        (target != requiredTarget ||
            !RegExp(r'^[0-9a-f]{32}$').hasMatch(nonce ?? ''))) {
      continue;
    }
    return (address: address, port: port, target: target, nonce: nonce);
  }
  return null;
}
