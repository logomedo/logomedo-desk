# Branding

Ime: **LogoMedoDesk**. Boje i znak iz LogoMeda (med `#d48a06`, tinta `#1d1a14`, papir `#f6f3ee`).

Gdje RustDesk drži ime i ikone (za fazu 3 u `docs/plan.md`):

- `vendor/hbb_common/src/config.rs`: `APP_NAME` (zadano „RustDesk”), `RENDEZVOUS_SERVERS`, `RS_PUB_KEY`
- `vendor/rustdesk/res/`: ikone (`icon.png`, `128x128*.png`, `mac-icon.png`, tray ikone)
- `vendor/rustdesk/flutter/windows/runner/resources/`, `vendor/rustdesk/flutter/macos/Runner/AppIcon.icns`
- bundle id i naziv u `flutter/macos/Runner/Configs/AppInfo.xcconfig`, `flutter/windows/runner/Runner.rc`

Izvorne datoteke znaka (SVG, PNG u svim veličinama) stavljamo ovdje, a skripta ih kopira u `vendor/` na granu `logomedo`.
