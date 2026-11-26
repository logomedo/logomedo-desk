# Forkovi i verzije

Svi forkovi su u organizaciji [logomedo](https://github.com/logomedo), napravljeni 26. 11. 2026. sa zadanom granom upstreama.
U ovom repou su submoduli u `vendor/`. Izmjene radimo na grani `logomedo` u forku, a `master`/`main` forka prati upstream.

| Submodul | Upstream | Zadana grana | Stanje pri forku |
|---|---|---|---|
| `vendor/rustdesk` | rustdesk/rustdesk | master | 1.5.3 (`Cargo.toml`) |
| `vendor/hbb_common` | rustdesk/hbb_common | main | |
| `vendor/rustdesk-server` | rustdesk/rustdesk-server | master | |
| `vendor/livekit` | livekit/livekit | master | |
| `vendor/client-sdk-flutter` | livekit/client-sdk-flutter | main | `livekit_client` 2.14.0 |
| `vendor/flutter-webrtc` | flutter-webrtc/flutter-webrtc | main | 1.6.3 |

`rustdesk` i `rustdesk-server` imaju svoj submodul `libs/hbb_common` koji pokazuje na **upstream** hbb_common. Kad prvi put
mijenjamo hbb_common, u `.gitmodules` forka RustDeska preusmjeriti ga na `logomedo/hbb_common`.

## Sinkronizacija s upstreamom

```bash
./scripts/upstream.sh          # za svaki fork: fetch upstream, fast-forward zadane grane, push u fork
```

Grana `logomedo` se zatim rebasea na novu zadanu granu. Prije svake nove verzije u distribuciji: build i ručni test.

## Verzije alata (zamka)

RustDesk CI (`vendor/rustdesk/.github/workflows/flutter-build.yml`) pri forku:

| Što | Verzija |
|---|---|
| Flutter (Windows x64, Linux, Android) | 3.24.5 |
| Flutter macOS arm64 | 3.44.9 (3.24.5 se na M-čipovima ruši, rustdesk#16817) |
| Flutter Windows arm64 | 3.44.9 (uz patch „Patch RustDesk sources for Flutter 3.44”) |
| Rust | 1.75 (Windows/Linux), 1.81 macOS |
| vcpkg commit | `9e593bb18ea69cc5095e012465dcd675a822ed0d` |
| flutter_rust_bridge | 1.80.1 |

**`livekit_client` 2.14 traži Dart ≥ 3.10, tj. Flutter ≥ 3.38.** Na macOS arm64 (3.44.9) to prolazi, a na Windows x64 (3.24.5)
ne. Moguće je ovo dvoje:

1. **Windows x64 na Flutter 3.44.9**, s istim patchem koji upstream već radi za Windows arm64. Gubi se Windows 7, što nama
   ne smeta. To je preporuka.
2. Stariji `livekit_client` koji podržava Dart 3.5. Tada se gube nove značajke i popravci.

`flutter_webrtc` 1.6.3 traži Dart ≥ 3.3, pa radi s obje verzije.
