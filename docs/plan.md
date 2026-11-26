# Plan po sesijama

LogoMedoDesk spaja dvije stvari koje logopedima i LogoMedo podršci danas trebaju odvojeno. Prvo, udaljenu podršku:
najčešći problem pri prijavi u LogoMedo je passkey u Chromeu bez Google računa, a korisnik treba samo pokrenuti exe i kliknuti
„Prihvati”. Drugo, daljinsku terapiju: logoped, roditelj i dijete s kamerom i mikrofonom, uz dijeljenje ekrana.
RustDesk (Flutter + Rust) već rješava ekran i upravljanje. Dodajemo WebRTC za kameru i mikrofon (1:1 pravi P2P, LiveKit za
sobe) i brendiranje. Arhitektura: [arhitektura.md](arhitektura.md). Verzije i zamke: [forkovi.md](forkovi.md).

## Tvrdi uvjeti (svaka sesija)

- Repo je **javan** (AGPL-3.0): bez ključeva, privatnih hostova, e-mailova i osobnih podataka. Ključevi i hostovi idu kroz env i CI secrete.
- Izmjene u `vendor/*` idu na granu `logomedo` **u forku** (commit i push u fork), zatim se ovdje commita pokazivač submodula.
  Diff prema upstreamu mora biti što manji.
- **Primarno računalo za razvoj je Windows** (ciljna platforma korisnika, odluka 1). macOS dolazi u S11.
- Dugi buildovi idu u pozadinu, a javljaju se samo na kraju ili kod greške.
- `logomedo.com` je drugi javni repo sa svojim pravilima (`../logomedo.com/CLAUDE.md`): staging prvo, produkcija samo na nalog.

## Sesije

| # | Faza | Paket | Odluke | Gotovo kad |
|---|---|---|---|---|
| S0 | — | Plan, forkovi, submoduli, skripte, compose | 1–20 | gotovo |
| S1 | F0 | Windows alati, `scripts/provjeri.sh`, build originala (Flutter 3.24.5), lokalni poslužitelji, spoj dvije instance | 100 | `provjeri.sh` zelen; `rustdesk.exe` izgrađen (exit 0); ID registriran na lokalnom hbbs (log); (!) veza s drugog računala prolazi; `docs/build-windows.md` |
| S2 | F0 | Flutter 3.44.9 na Windows x64 + `livekit_client` i `flutter_webrtc` u RustDesk pubspec; primjeri | 200 | build s ovisnostima exit 0; LiveKit primjer: 2 sudionika u sobi; flutter-webrtc loopback radi. **Vrata ako 3.44 ne prolazi.** |
| S3 | F1 | Branding, build-time server i ključ, varijanta „brza podrška” | 300 | exe nosi ime i ikonu (snimka zaslona u `docs/`); varijanta podrške u kodu odbija odlazne veze i traži klik; `provjeri.sh` zelen |
| S4 | F2 | WebRTC signalizacija kroz RustDesk vezu (proto, Rust, most do Fluttera) | 400 | `cargo test` zelen s novim testom; log razmjene SDP između dvije instance |
| S5 | F2 | Video i zvuk 1:1 P2P u prozoru sesije | 500 | (!) dva računala se vide i čuju; `getStats` zapisan (Opus, tip kandidata, bitrate) |
| S6 | F2 | TURN + prisilni relay + mjerenje zvuka (sibilanti) | 600 | veza samo preko relaya radi; mjerenje u `docs/research/` |
| S7 | F3 | `MedijSesija` (P2P i LiveKit), lokalni dev token | 700 | (!) 3 klijenta u sobi; prebacivanje P2P ↔ LiveKit bez diranja ekrana |
| S8 | F4 | logomedo.com: zahtjevi za podršku, `/admin/uprava/podrska`, LiveKit token (staging) | 800 | `npm test && npm run check && npm run build` zeleni u `../logomedo.com`; E2E na stagingu. **Vrata: produkcija.** |
| S9 | F4 | Brza podrška exe → staging API → Spoji iz admina | 900 | (!) E2E na stagingu: exe pokrenut → zahtjev u adminu → spojeno |
| S10 | F5 | GitHub Actions Windows build, priprema potpisa i produkcijskih poslužitelja | 1000 | CI artefakt (nepotpisan) iz `main`. **Vrata: tvrtka za potpis, hosting, domena, trošak.** |
| S11 | F5 | macOS build (Flutter 3.44.9), priprema notarizacije | 1100 | `.app` se gradi i spaja na lokalni hbbs; `docs/build-macos.md` |

## Procjena, vrata, rizici

- **12 sesija** (S0–S11), bez procjene trajanja: S1 mjeri koliko traje build (vcpkg i cargo su najsporiji).
- **Vrata:**
  - nakon S2 samo ako Flutter 3.44.9 na Windows x64 ne prolazi (tada korisnik bira: stariji `livekit_client` ili čekanje upstreama);
  - nakon S8 produkcija logomedo.com;
  - u S10 potpisivanje (tvrtka, Azure), hosting i domena poslužitelja, svaki trošak.
- **(!)** označava korake koji traže korisnika ili drugo računalo (kamera, mikrofon, klik „Prihvati”). Sesija pripremi sve i
  upiše što točno korisnik treba napraviti; ako korisnik nije tu, upiše to na vrh sljedećeg handoffa i lanac staje.
- **Najrizičniji:** S2 (Flutter 3.44 na Windows x64 s RustDeskom i LiveKitom zajedno, plus WebRTC nativni pluginovi uz
  RustDeskove), S4 (diranje RustDesk protokola i flutter_rust_bridge mosta), S6 (kvaliteta zvuka za logopediju je pravi cilj
  terapije, a mjeri se tek ovdje).
- **Paralelno:** S11 (macOS) može bilo kad nakon S3, na Macu, jer ne mijenja iste datoteke. S8 (logomedo.com) može paralelno
  sa S5–S7 jer je drugi repo. Ostalo je linearno.
- **Izvođenje:** `todo-plan-exec` radi samo na macOS-u (iTerm2). Na Windowsu se lanac vrti ručno: nova sesija i „nastavi
  logomedo-desk”, odnosno sadržaj sljedećeg `SN.md`.

## Gdje smo

S0 (26. 11. 2026.): plan, forkovi, submoduli, skripte i compose. Koda u forkovima još nema, ništa nije izgrađeno.
Lokalni poslužitelji provjereni na macOS-u.
