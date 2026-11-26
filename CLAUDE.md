# LogoMedoDesk

Javni repo (AGPL-3.0): github.com/logomedo/logomedo-desk. Fork RustDeska za podršku i daljinsku terapiju, s kamerom i
mikrofonom kroz WebRTC: 1:1 je pravi P2P (`flutter_webrtc`), a LiveKit je za sobe. Početna točka je `README.md`, zatim
`docs/arhitektura.md`, `docs/plan.md` (faze, prvi neoznačeni korak je sljedeći posao) i `docs/forkovi.md` (verzije i zamke).

## Pravila

- Javan repo: nikakvi tokeni, privatni hostovi, e-mailovi, ključevi relaya ni osobni podaci. Ključevi i hostovi za build idu
  kroz env/CI secrete, ne u kod.
- `vendor/*` su submoduli na forkove u `logomedo/`. Naše izmjene idu na granu `logomedo` **u forku** (commit i push u fork),
  a zatim se u ovom repou commita novi pokazivač submodula. Zadana grana forka samo prati upstream (`scripts/upstream.sh`).
- Ne mijenjati upstream kod bez potrebe: što manji diff, da rebase na novu verziju RustDeska ostane lak.
- Razvoj na macOS-u (Apple Silicon), Windows build na zasebnom Windows računalu (isti repo, `scripts\postavi.ps1`).
  Točne naredbe za build zapisuju se u `docs/build-macos.md` i `docs/build-windows.md` čim prvi put prođu.
- Flutter verzija je zamka (`docs/forkovi.md`): RustDesk Windows x64 je na 3.24.5, `livekit_client` traži ≥ 3.38. Sistemski
  Flutter se ne dira; koristiti FVM (`.fvm/` je u .gitignore) ili zasebnu instalaciju.
- Dugi buildovi (vcpkg, cargo, flutter) idu u pozadinu, a javljaju se samo na kraju ili kod greške, bez obavijesti o napretku.
- Commit poruke na hrvatskom, `tip(opseg): sažetak`.

Veza s web aplikacijom: `../logomedo.com` (Astro + Cloudflare Workers). LiveKit tokeni i zahtjevi za podršku idu kroz nju
(`docs/plan.md`, faze 5 i 6).
