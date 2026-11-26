# Handoffi za sesije S1–S11

Plan je u [../plan.md](../plan.md). Svaka sesija ima svoj handoff `SN.md`, koji je gotov prompt za praznu sesiju.
Nakon `/clear` korisnik kaže „nastavi logomedo-desk” ili zalijepi prompt iz clipboarda.

## Lanac

1. Sesija N počinje iz `docs/handoffs/SN.md`.
2. Sesija N radi svoj paket po pravilima ispod.
3. Na kraju sesija N:
   - označi `SN` u tablici „Stanje lanca” (commit, testovi, kratka napomena) i stavke u `TODO.md`;
   - **ako je naučila nešto što mijenja neki od sljedećih paketa, uredi `S(N+1).md`**, a po potrebi i kasnije handoffe i
     plan. Nedovršeni dio paketa N ide na **vrh** `S(N+1).md`;
   - u `S(N+1).md` upiše polazni commit i stanje `./scripts/provjeri.sh`;
   - pozove `/wrap-up`. Handoff prompt (clipboard i `~/.claude/handoffs/logomedo-desk/`) je sadržaj `S(N+1).md`.
4. Ako sesija ostane bez konteksta usred paketa, nastavak je opet `SN` s popisom onoga što je ostalo na vrhu datoteke.
   Broj se ne povećava.
5. **Vrata** (nakon S2 ako Flutter 3.44 ne prolazi, nakon S8, u S10) i koraci (!) koji traže korisnika: sesija pripremi sve,
   upiše pitanje ili uputu na **vrh** sljedećeg handoffa, i lanac staje dok korisnik ne odluči ili ne napravi korak.
6. Handoff se mijenja samo prema naprijed: gotovi `SN` se ne prepisuju, služe kao povijest.

Izvođenje: na macOS-u `/todo-plan-exec docs/handoffs/`, a na Windowsu ručno, sesiju po sesiju (odluka 10).

## Stanje lanca

| Sesija | Paket | Stanje | Commit | Provjera | Napomena |
| --- | --- | --- | --- | --- | --- |
| S0 | Plan, forkovi, submoduli, skripte, compose | gotovo | 8b16903 | compose na macOS-u | odluke 1–11 |
| S1 | Windows alati, build originala, lokalni poslužitelji | otvoreno | | | |
| S2 | Flutter 3.44.9 + livekit_client + flutter_webrtc | otvoreno | | | vrata ako 3.44 ne prolazi |
| S3 | Branding i varijanta brza podrška | otvoreno | | | |
| S4 | WebRTC signalizacija kroz RustDesk vezu | otvoreno | | | |
| S5 | Video i zvuk 1:1 P2P | otvoreno | | | (!) dva računala |
| S6 | TURN, relay, mjerenje zvuka | otvoreno | | | (!) snimke |
| S7 | MedijSesija + LiveKit | otvoreno | | | (!) tri klijenta |
| S8 | logomedo.com: podrška i LiveKit token | otvoreno | | | vrata: produkcija |
| S9 | Brza podrška → staging → Spoji | otvoreno | | | (!) E2E |
| S10 | CI build, priprema potpisa i poslužitelja | otvoreno | | | vrata: trošak, tvrtka, hosting |
| S11 | macOS build | otvoreno | | | na Macu, bilo kad nakon S3 |

## Zajednička pravila (vrijede u svakoj sesiji)

- **Polazak:** `./scripts/provjeri.sh` (od S1; na Windowsu u Git Bashu) i potvrda u jednoj rečenici da je zeleno. Ako nije
  zeleno, prvo to popravi. Zatim `git submodule update --init --recursive` ako je drugo računalo pomaknulo pokazivače.
- **Opseg:** ovaj repo i forkovi u `vendor/` (grana `logomedo`); `../logomedo.com` samo u S8 i S9, po njegovom `CLAUDE.md`.
  Ništa izvan toga.
- **Git:** u forku commit i push na `logomedo`, zatim u ovom repou commit pokazivača submodula i push `main`. Poruke na
  hrvatskom, `tip(opseg): sažetak`.
- **Orkestracija:** posao rade Opus 5.5 subagenti (`model: "opus"`), glavna sesija orkestrira. Paket razbij na dva agenta:
  (a) implementacija, (b) testovi, build i spajanje. Effort uvijek eksplicitno: `high` za kod, `medium` za čitanje. Najviše
  2–3 agenta paralelno. Fable samo uz korisnikov izričit pristanak.
- **Agentima zabrani** `TODO.md`, `docs/plan.md`, `docs/decisions.md` i handoffe. Orkestrator ih ažurira.
- **Testovi:** bez mreže gdje god može, `skipped 0`. Ručne provjere (!) zapisuju ishod s brojkama (log, `getStats`).
- **Brojke s naredbom:** trajanje builda, veličina exe-a, bitrate i latencija zapisuju se uz naredbu kojom su izmjerene.
  Nikad procjena kao činjenica.
- **Trošak:** procjena prije svega što ide preko ~100 LLM poziva; nikad `claude -p` petlja. Plaćene usluge (Azure, VPS,
  domena) samo na korisnikov nalog.
- **Autonomno:** odluči sam i zapiši odluku u svoj blok. Svaki zeleni korak commitaj. Nepovratno i vanjsko (objava, potpis,
  produkcija, trošak) ostavi korisniku.
- **Token budget:** bez Monitora koji javlja napredak; dugi buildovi s `run_in_background`, javljaju se samo na kraju ili kod
  greške. Oko 150k konteksta orkestratora zatvori sesiju po koraku 3 lanca.
- **Javni repo:** nikakvi ključevi, hostovi, e-mailovi ni osobni podaci (odluka 7).
- Istraživanja idu u `docs/research/YYYY-MM-DD-*.md`.
