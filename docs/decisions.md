# Odluke

Svaka odluka ima broj, datum, razlog i uvjet revizije. Odluka se ne briše, nego zamjenjuje novom koja se poziva na staru.
Blokovi po sesiji: S0 1–99, S1 100–199, S2 200–299, … S11 1100–1199.

## S0 (26. 11. 2026.)

**1. Primarno računalo za razvoj je Windows.** Korisnici su većinom na Windowsu, a Windows build je ionako potreban. macOS
build dolazi u S11. *Revizija:* ako Windows računalo nije dostupno, lanac ide na macOS (Flutter 3.44.9, `docs/forkovi.md`).

**2. Ekran ostaje RustDeskov, kamera i mikrofon idu kroz WebRTC.** RustDeskov protokol je optimiziran za oštar ekran i
upravljanje, a nema poništavanje jeke. WebRTC ga ima. Dva prijenosa rade jedan uz drugog i ne miješaju se (`arhitektura.md`).

**3. 1:1 je pravi P2P (`flutter_webrtc`), a LiveKit je tu od prvog dana.** P2P za logopeda i jednu obitelj, LiveKit (SFU) za
više sudionika, snimanje uz privolu i mobitele. Oba iza istog sloja `MedijSesija` (S7).

**4. WebRTC signalizacija ide kroz već otvorenu RustDesk vezu** (nova protobuf poruka). Ne treba signalizacijski poslužitelj
ni soba za 1:1. *Revizija:* ako se u S4 pokaže da je most Rust ↔ Flutter za to preskup, signalizacija ide kroz WebSocket na
logomedo.com (Durable Object).

**5. Izmjene u forkovima idu na granu `logomedo`, zadana grana prati upstream**, diff što manji, da rebase na novu verziju
RustDeska ostane lak (`scripts/upstream.sh`).

**6. Prvo reproducirati upstream build (Flutter 3.24.5 na Windows x64), pa tek onda bump na 3.44.9.** Tako se greška u
alatima ne miješa s greškom koju unosi bump (S1 pa S2).

**7. Javni repo bez tajni.** Rendezvous host, javni ključ, LiveKit ključevi i tokeni idu kroz env i CI secrete. U repou su
samo dev vrijednosti (`devkey`/`secret` za lokalni LiveKit).

**8. logomedo.com dio radi se u `../logomedo.com` po njegovim pravilima.** Staging prvo, produkcija samo na korisnikov nalog
(vrata nakon S8).

**9. Testiranje:** Rust izmjene imaju `cargo test` za naše module; Dart izmjene `flutter analyze` (bez novih upozorenja) i
`flutter test` gdje ima smisla. Ručne provjere s dva računala ili kamerom su označene (!), a ishod se zapisuje u TODO i handoff
s brojkama iz `getStats` ili loga. Nema tiho preskočenih testova.

**10. Lanac na Windowsu se vrti ručno.** `todo-plan-exec` ovisi o iTerm2 i radi samo na macOS-u; na Windowsu nova sesija
dobije sadržaj sljedećeg `SN.md` („nastavi logomedo-desk”).

**11. Ime je „LogoMedoDesk”**, a varijanta za korisnike „LogoMedoDesk brza podrška”. *Revizija:* korisnik može promijeniti
ime prije S3.
