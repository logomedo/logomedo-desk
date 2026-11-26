# LogoMedoDesk

Udaljena podrška i daljinska logopedska terapija za [LogoMedo](https://logomedo.com).

- **Ekran i upravljanje:** [RustDesk](https://github.com/rustdesk/rustdesk) (Flutter + Rust), skoro bez izmjena.
- **Kamera i mikrofon:** WebRTC s poništavanjem jeke. 1:1 ide pravim P2P-om ([flutter-webrtc](https://github.com/flutter-webrtc/flutter-webrtc)),
  a [LiveKit](https://livekit.io) je od prvog dana tu za sobe, više sudionika i snimanje uz privolu.
- **Vlastiti poslužitelji:** RustDesk relay (hbbs/hbbr), TURN i LiveKit.

Stanje: početak (26. 11. 2026.). Ništa još nije izgrađeno. Plan je u [docs/plan.md](docs/plan.md), arhitektura u
[docs/arhitektura.md](docs/arhitektura.md).

## Struktura

| Put | Što |
|---|---|
| `vendor/rustdesk` | fork [logomedo/rustdesk](https://github.com/logomedo/rustdesk) (klijent, Flutter UI u `flutter/`) |
| `vendor/hbb_common` | fork [logomedo/hbb_common](https://github.com/logomedo/hbb_common) (zajednički kod; u RustDesku je i kao `libs/hbb_common`) |
| `vendor/rustdesk-server` | fork [logomedo/rustdesk-server](https://github.com/logomedo/rustdesk-server) (hbbs/hbbr) |
| `vendor/livekit` | fork [logomedo/livekit](https://github.com/logomedo/livekit) (LiveKit server, Go) |
| `vendor/client-sdk-flutter` | fork [logomedo/client-sdk-flutter](https://github.com/logomedo/client-sdk-flutter) (`livekit_client`) |
| `vendor/flutter-webrtc` | fork [logomedo/flutter-webrtc](https://github.com/logomedo/flutter-webrtc) |
| `server/` | lokalni razvojni poslužitelji (Docker Compose) |
| `branding/` | ime, ikone, boje |
| `scripts/` | postavljanje (macOS i Windows) i sinkronizacija s upstreamom |
| `docs/` | arhitektura, plan, forkovi |

## Početak

```bash
git clone --recursive https://github.com/logomedo/logomedo-desk.git
cd logomedo-desk
./scripts/postavi.sh        # macOS; na Windowsu: powershell -File scripts\postavi.ps1
```

Skripta povuče submodule (i ugniježđeni `libs/hbb_common`) i svakom forku doda remote `upstream`.

## Licenca

AGPL-3.0, kao RustDesk (vidi [LICENSE](LICENSE)). Svaki distribuirani build mora imati dostupan izvorni kod, pa je repo javan.
RustDesk je zaštitni znak svojih autora; LogoMedoDesk nije službeni RustDesk proizvod.
