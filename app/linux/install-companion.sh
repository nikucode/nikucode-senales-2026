#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
app_dir=$(cd -- "$script_dir/.." && pwd)

cd "$app_dir"
flutter pub get --offline || flutter pub get
flutter build linux --release

install_dir="$HOME/.local/lib/nikucode-pausa"
service_dir="$HOME/.config/systemd/user"
mkdir -p "$install_dir" "$service_dir"
cp -a "$app_dir/build/linux/x64/release/bundle/." "$install_dir/"
install -m 0644 "$script_dir/nikucode-pausa.service" "$service_dir/nikucode-pausa.service"
systemctl --user daemon-reload
systemctl --user enable --now nikucode-pausa.service
systemctl --user status --no-pager nikucode-pausa.service
