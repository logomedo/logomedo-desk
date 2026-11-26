# TODO — LogoMedoDesk

Radna lista. Čuva se u repou da napredak preživi između sesija. Označene stavke su gotove i provjerene
(`./scripts/provjeri.sh` zelen, nastaje u S1). Odluke idu u [docs/decisions.md](docs/decisions.md).

Plan po sesijama: [docs/plan.md](docs/plan.md). Handoff po sesiji: [docs/handoffs/](docs/handoffs/).

Legenda: `[x]` gotovo · `[ ]` otvoreno · `[~]` u radu · `(!)` traži korisnika · `→ Sn` planirana sesija

## F0 — temelj i mjerenje (ništa javno, bez troška)

- [x] Forkovi u `logomedo/`, submoduli u `vendor/`, `scripts/postavi.*`, `scripts/upstream.sh` (S0)
- [x] `server/docker-compose.yml`: hbbs, hbbr, LiveKit `--dev` se dižu na macOS-u (S0)
- [ ] Windows alati: Visual Studio Build Tools (C++), LLVM, vcpkg na commitu iz `docs/forkovi.md`, Rust, Flutter 3.24.5 izvan sistemskog → S1
- [ ] `scripts/provjeri.sh`: verzije alata prema `docs/forkovi.md`, stanje submodula, brzi testovi naših izmjena → S1
- [ ] Build originala `vendor/rustdesk` na Windowsu (upstream Flutter 3.24.5), točne naredbe i trajanja u `docs/build-windows.md` → S1
- [ ] Lokalni poslužitelji na Windowsu (Docker Desktop ili izvorni `hbbs.exe`/`hbbr.exe`/`livekit-server`) → S1
- [ ] (!) Dvije instance spojene preko lokalnog hbbs/hbbr (Windows build ↔ drugo računalo) → S1
- [ ] Flutter 3.44.9 za Windows x64 uz upstreamov patch za 3.44 (iz Windows arm64 joba) → S2
- [ ] `livekit_client` i `flutter_webrtc` dodani u `vendor/rustdesk/flutter/pubspec.yaml`, build prolazi → S2
- [ ] Primjer `vendor/client-sdk-flutter/example`: dva sudionika u sobi na lokalnom LiveKitu → S2
- [ ] Primjer `vendor/flutter-webrtc/example` (loopback, kamera i mikrofon) → S2

## F1 — branding i varijante

- [ ] `APP_NAME` „LogoMedoDesk”, ikone (`res/`, `flutter/windows/runner/resources`, `flutter/macos/Runner/AppIcon.icns`), bundle id i `Runner.rc` → S3
- [ ] Izvorne datoteke znaka u `branding/` i skripta koja ih kopira u `vendor/rustdesk` → S3
- [ ] Rendezvous poslužitelj i javni ključ ugrađeni u build kroz env (bez ključeva u repou) → S3
- [ ] Varijanta „brza podrška”: samo dolazne veze, pristanak klikom, bez instalacije → S3

## F2 — kamera i mikrofon, 1:1 P2P

- [ ] Nova protobuf poruka za WebRTC signalizaciju (SDP, ICE) u `hbb_common` i prosljeđivanje kroz RustDesk vezu do Fluttera → S4
- [ ] Rust test za novu poruku (serijalizacija i prosljeđivanje) → S4
- [ ] `flutter_webrtc` u prozoru sesije: lokalni i udaljeni video, mute, odabir uređaja → S5
- [ ] Postavke zvuka: AEC uključen, `noiseSuppression`/`autoGainControl` isključeni, Opus mono 48 kHz, ciljani bitrate → S5
- [ ] (!) Dva računala se vide i čuju; `getStats` (kodek, tip kandidata, bitrate) zapisan → S5
- [ ] TURN (coturn u `server/docker-compose.yml`) i prisilni relay (`iceTransportPolicy: relay`) → S6
- [ ] (!) Mjerenje zvuka za sibilante (snimka s obje strane, usporedba) u `docs/research/` → S6

## F3 — LiveKit

- [ ] Sloj `MedijSesija` s dvije izvedbe (P2P, LiveKit), ekran se ne dira → S7
- [ ] Lokalni dev token (skripta), spajanje u sobu iz prozora sesije → S7
- [ ] (!) Tri klijenta u sobi na lokalnom LiveKitu → S7

## F4 — veza s logomedo.com (drugi repo)

- [ ] `../logomedo.com`: D1 tablica zahtjeva za podršku, `POST /api/podrska` (ID + jednokratni kod), zaštita od spama → S8
- [ ] `/admin/uprava/podrska`: popis zahtjeva i gumb Spoji (`rustdesk://` poveznica) → S8
- [ ] LiveKit token endpoint samo za prijavljenog logopeda → S8
- [ ] (!) Produkcija logomedo.com tek na korisnikov nalog → vrata nakon S8
- [ ] Brza podrška exe prijavi zahtjev na staging API; E2E zahtjev → admin → spoj → S9

## F5 — distribucija

- [ ] GitHub Actions: Windows build (nepotpisan artefakt) uz secrete za server i ključ → S10
- [ ] (!) Potpisivanje (Azure Artifact Signing na tvrtku), hosting relaya/TURN/LiveKita, domena → vrata u S10
- [ ] macOS build (Flutter 3.44.9) i priprema notarizacije → S11
