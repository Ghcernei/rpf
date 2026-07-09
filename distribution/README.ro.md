# Qroky — instalare de sine stătătoare

## Ce face acest instalator

Un singur script, `install.sh`, duce un calculator curat la un asistent
funcțional în mai puțin de 15 minute. Îți pune exact **șapte întrebări**
(listate mai jos), îți pregătește un folder privat pe propriul calculator,
și se termină cu cuvintele pe care le spui ca să începi prima conversație.
Nu întreabă niciodată nimic în afara acestor șapte întrebări — orice altă
linie afișată este fie progres, fie rezultatul unei verificări, fie (la o
problemă reală) o instrucțiune clară de rezolvare, cu pasul exact următor.

## Comanda unică

```
bash install.sh
```

Rulează-o din folderul unde ai dezarhivat/clonat acest kit. Dacă lipsește
ceva (git, curl, chiar asistentul Claude Code), scriptul se oprește și îți
spune exact ce să instalezi și cum — apoi rulezi din nou aceeași comandă,
și continuă chiar de unde s-a oprit. Nimic nu se repetă, nimic la care ai
răspuns deja nu se întreabă a doua oară.

## Cele șapte întrebări

1. **Limba** — English, Română, sau Русский. Tot ce urmează după acest
   punct este afișat în limba aleasă.
2. **Folderul de lucru** — unde ar trebui să stea spațiul tău privat
   Qroky. Este sugerată o cale rezonabilă; apasă Enter pentru a o accepta,
   sau scrie propria cale.
3. **Verificarea Claude Code** — instalatorul verifică dacă asistentul
   Claude Code este deja pe acest calculator. Dacă nu, primești linkul
   exact de instalare și instrucțiunile; rulează instalatorul din nou după
   ce e instalat.
4. **Verificarea abonamentului** — o verificare rapidă, care nu blochează,
   că autentificarea/abonamentul tău Claude Code pare activ. E o
   verificare, nu un flux de cumpărare — dacă nu poate confirma, doar te
   anunță, nu te oprește niciodată.
5. **Telegram (opțional)** — vrei un rezumat de dimineață și actualizări
   prin Telegram? Dacă da, instalatorul te duce pas cu pas prin crearea
   propriului tău bot cu BotFather, și verifică live că token-ul
   funcționează înainte de a-l salva. Poți sări peste oricând — scrie
   "skip".
6. **Partajarea sprijinului zilnic (opțional)** — vezi „Ce pleacă de pe
   acest calculator" mai jos, înainte de a fi întrebat. Oprită implicit.
7. **Rezumatul de dimineață (opțional)** — un mesaj scurt zilnic: ce s-a
   făcut, ce te așteaptă. Recomandat: da. Te poți răzgândi oricând (vezi
   „Nu-mi atinge instanța" mai jos).

## Ce pleacă de pe acest calculator

Dacă activezi partajarea sprijinului zilnic la întrebarea 6, doar acestea —
și nimic altceva — ar pleca vreodată de pe acest calculator (lista
completă; orice nu e pe ea este omis, niciodată citit):

1. **Fișierele de progres ale sarcinilor (`STATUS.md`)** — doar cuvântul de
   stare, data și identificatorul sarcinii; notele libere sunt eliminate.
2. **Rezumatele de cost (`RESULT.md`)** — DOAR cifrele de cost
   (timp/unități); secțiunile de rezumat și conținut, unde ar fi descris
   produsul tău, nu sunt copiate niciodată.
3. **Jurnalele de pași (`run.log`)** — doar marcaje de timp și nume de pași.
4. **Tabloul de stare (`status.yaml`)** — o linie per sarcină; notele
   libere sunt eliminate.
5. **Rezultatele verificărilor independente (`VERDICT.md`)** — doar linia
   de verdict, niciodată textul constatărilor.

Niciodată codul, specificațiile sau conținutul produsului tău — acestea nu
sunt pe listă și nu sunt citite niciodată. De reținut: acest instalator
doar **îți înregistrează alegerea** — nu instalează niciun mecanism de
trimitere, deci nimic nu poate pleca nici după un „da". Înainte ca vreun
script de trimitere să fie adăugat vreodată în spațiul tău de lucru, îți va
fi arătat chiar acel script — bash simplu, lizibil, pe care îl poți
verifica linie cu linie față de lista de mai sus.

## Nu-mi atinge instanța

Instalatorul nu schimbă niciodată nimic ce nu ai cerut, iar orice piesă
opțională pe care o pornește poate fi oprită la fel de ușor:

- **Oprește rezumatul de dimineață:** șterge fișierul din folderul
  `.qroky/launchd/` al spațiului tău de lucru din `~/Library/
  LaunchAgents/`, sau pur și simplu nu răspunde „da" la întrebarea 7 de la
  început — rezumatul e instalat-dar-oprit în acest caz, cu comanda exactă
  de pornire afișată pentru tine.
- **Pornește rezumatul de dimineață mai târziu:**
  `bash install.sh --enable-heartbeat`
- **Verifică o actualizare a regulilor (doar citire, nu schimbă nimic):**
  `bash install.sh --check-update`
- **Vezi mai multe detalii despre o actualizare în așteptare:**
  `bash install.sh --show-update-details`
- **Aplică o actualizare în așteptare (doar după ce confirmi explicit):**
  `bash install.sh --apply-update` — dacă ai făcut propriile modificări în
  folderul vendorizat `framework/`, instalatorul îți ARATĂ exact ce ar fi
  afectat înainte de a atinge ceva; nu suprascrie niciodată pe ascuns
  schimbările tale.

## Sigur de rulat din nou, oricând

Fiecare pas al instalatorului este o pereche „verifică, apoi fă": pe un
spațiu de lucru sănătos, deja configurat, rularea din nou a `install.sh`
este o verificare de sănătate gratuită, care nu schimbă nimic și nu
întreabă nimic din nou. Dacă instalatorul e întrerupt la mijloc (pană de
curent, terminal închis, orice), rularea din nou continuă exact de unde a
rămas — răspunsurile pe care le-ai dat deja sunt păstrate în
`install-state.json` din spațiul tău de lucru, un fișier text simplu, pe
care ești liber să-l citești.
