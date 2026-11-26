# Plan

Razvoj na macOS-u (Apple Silicon), a Windows build na zasebnom Windows računalu s Claude Codeom (isti repo, `--recursive`).

## Faza 0: temelj (gotovo 26. 11. 2026.)

- [x] Forkovi u `logomedo` i submoduli u `vendor/`
- [x] Arhitektura, verzije i zamke (`docs/`)
- [x] Skripte za postavljanje (macOS, Windows) i sinkronizaciju s upstreamom
- [x] `server/docker-compose.yml`: hbbs, hbbr, LiveKit (dev)

## Faza 1: upogoniti original lokalno (macOS)

- [ ] Flutter 3.44.9 (preko FVM-a ili zasebne instalacije, da se ne dira sistemski Flutter), Rust 1.81+, vcpkg na commitu iz `forkovi.md`
- [ ] Build `vendor/rustdesk` po upstream uputama (`python3 build.py --flutter`), pokrenuti, spojiti se na lokalni hbbs/hbbr
- [ ] Pokrenuti primjer iz `vendor/client-sdk-flutter/example` na lokalni LiveKit (`server/`), dva prozora u istoj sobi
- [ ] Pokrenuti primjer iz `vendor/flutter-webrtc/example` (loopback)
- [ ] Zapisati točne naredbe i trajanja u `docs/build-macos.md`

## Faza 2: Windows build

- [ ] Klon na Windows računalu, `scripts\postavi.ps1`, Visual Studio Build Tools, vcpkg, LLVM, Flutter 3.44.9
- [ ] Odluka o Flutteru za Windows x64 (`forkovi.md`, zamka) i test patcha za 3.44
- [ ] Zapisati u `docs/build-windows.md`

## Faza 3: branding

- [ ] `APP_NAME` „LogoMedoDesk”, ikone (`res/`, `flutter/windows/runner/resources`, `flutter/macos/Runner/AppIcon.icns`), bundle id
- [ ] Zadani rendezvous poslužitelj i javni ključ ugrađeni u build (`RENDEZVOUS_SERVER`, `RS_PUB_KEY`)
- [ ] Samo dolazne veze za korisničku verziju (`conn-type=incoming`), pristanak klikom (`approve-mode=click`), bez instalacije

## Faza 4: kamera i mikrofon, 1:1 P2P

- [ ] Nova protobuf poruka za WebRTC signalizaciju kroz RustDesk vezu
- [ ] `flutter_webrtc` u `vendor/rustdesk/flutter`: lokalni/udaljeni video u prozoru sesije, mute, odabir uređaja
- [ ] Postavke zvuka za logopediju (`arhitektura.md`)
- [ ] TURN za stroge mreže

## Faza 5: LiveKit

- [ ] `livekit_client` u istom UI sloju (`MedijSesija`)
- [ ] Token za sobu iz logomedo.com (Worker, samo prijavljeni logoped)
- [ ] Soba logoped + roditelj + dijete; snimanje tek uz privolu (kasnije)

## Faza 6: veza s logomedo.com

- [ ] `/admin/uprava/podrska`: zahtjevi za podršku (RustDesk ID javlja klijent, kratki jednokratni kod), gumb Spoji
- [ ] Za terapiju: zakazivanje sesije i poveznica za roditelja

## Otvoreno

- Potpisivanje: Windows (Azure Artifact Signing na tvrtku), macOS (Developer ID + notarizacija)
- Smjer ekrana kod terapije (`arhitektura.md`, „Smjer”)
- Hosting poslužitelja (relay, TURN, LiveKit) i domena (DNS only, izvan Cloudflare proxyja)
