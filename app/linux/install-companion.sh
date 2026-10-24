#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
app_dir=$(cd -- "$script_dir/.." && pwd)

cd "$app_dir"
flutter pub get --offline || flutter pub get
flutter build linux --release

systemctl --user show-environment >/dev/null

install_root="$HOME/.local/lib"
install_dir="$install_root/nikucode-pausa"
service_dir="$HOME/.config/systemd/user"
mkdir -p "$install_root" "$service_dir"
bundle_dir="$app_dir/build/linux/x64/release/bundle"
# Running windows may still map the executable and Flutter libraries. Prepare
# the complete bundle elsewhere, then retain the old directory for those
# windows instead of modifying their mapped files in place.
staging_dir=$(mktemp -d "$install_root/.nikucode-pausa.new.XXXXXX")
cp -a "$bundle_dir/." "$staging_dir/"
systemctl --user stop nikucode-pausa.service 2>/dev/null || true
if [[ -e "$install_dir" ]]; then
  previous_dir="$install_root/.nikucode-pausa.previous.$(date +%s).$$"
  mv "$install_dir" "$previous_dir"
fi
mv "$staging_dir" "$install_dir"
install -m 0644 "$script_dir/nikucode-pausa.service" "$service_dir/nikucode-pausa.service"
systemctl --user daemon-reload
systemctl --user enable nikucode-pausa.service
systemctl --user restart nikucode-pausa.service
systemctl --user status --no-pager nikucode-pausa.service
