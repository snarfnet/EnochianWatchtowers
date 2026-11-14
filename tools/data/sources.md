# Sources, what each one confirmed, and how conflicts were settled

Key = the short name used in `derived_names.json` (`publishedMatches` / `publishedDifferent`).

## Sources used

| Key | Source | URL | Used for |
|---|---|---|---|
| (grid) PETERSON | Joseph H. Peterson, *Tabula bonorum angelorum invocationes* of Dr John Dee (BL Sloane MS 3191), esotericarchives.com. HTML page holds a plain-text copy of the 1587 Recensa grid (in an HTML comment) and a typeset image of the MS page. | https://www.esotericarchives.com/dee/invocat.htm , image https://www.esotericarchives.com/dee/invocat3_sl3191.jpg | Primary transcription of the **1587 Tabula Recensa**. I read the image by eye to check the text copy. |
| DEE | Same page: Dee's own lists of the 12 names of God, 24 Seniors, the 16 Calvary-cross pairs, kerubic and servient names. | same | Published names. Dee built these mostly from the 1584 letters, so a mismatch with DEE often just marks a 1584 -> 1587 letter change. |
| (grid) KONDOR | kondor.de, "The Four Watchtowers": three HTML-table transcriptions: original 1584 table, Raphael's reformed 1587 table, Sloane 307 cover table. | http://www.kondor.de/enoch/tables.html | Second transcription of the **1587** grid; base grid of the **1584** set; Sloane 307 variant (`yl`, `Æ`, `Q`). |
| KONDOR | Kondor, "The Angels of the Four Quadrants - according to the Golden Dawn". Uses Schueler spellings (K for C). | http://www.kondor.de/enoch/gdengel_e.html | GD names: 12 names of God, kings, 24 seniors with planets, 32 cross names, 64 prefixed servient names. |
| TFR | Meric Casaubon (ed.), *A True & Faithful Relation* (London 1659), pp.175-178, archive.org scan `truefaithfulrela00deej` (page images n264-n266, read by eye; the OCR text is too noisy to trust). | https://archive.org/details/truefaithfulrela00deej | 1584 grid as dictated (cross-check of the 1584 set); Dee's derivation rules for names of God, King, Seniors, kerubic rotation. |
| CROWLEY | Aleister Crowley, *Liber Chanokh* (Equinox I:7-8, 1912), Celephaïs Press e-text with transcriber notes (2002-2004). Plate III ("general view") gives the whole Great Table; text gives the Water-tablet names as worked examples. | https://www.astrumargenteum.org/wp-content/uploads/2016/07/0084-Liber-Chanokh.pdf | GD-lineage grid (letters extracted from the PDF by position); MPH ARSL GAIOL; four kings; Water seniors, crosses, kerubic, servient; note 9 (Plate III mixes 1584, 1587 and Liber Scientiae letters); note 10 (Dee vs GD prefix rules). |
| BOOKH | Golden Dawn **Book "H"**, *Clavicula Tabularum Enochi*, Westcott's abridgement of Sloane MS 307 (Thelemagick Library transcription from *The Seventh Ray*). Prints the tablets with 2-3 letters in some squares. | https://www.tarrdaniel.com/documents/Thelemagick/gd/publication/english/golden_dawn_manuscripts.html (section "Manuscript H") | GD grid variants; Tablet of Union `exarp / hComa / nanTa / bitom`; Air names (King, Seniors, crosses, kerubic, servient); Water crosses and H-prefixed kerubic names; NBOZA / NTAOM for Earth. |
| GDCONS | GD ritual "Consecration of the Elemental Weapons" (same page, from Regardie's *Golden Dawn*). | same URL | Kings (pronounced forms), all 24 seniors, all 16 prefixed kerubic ruling names (ERZLA, EYTPA, ETNBR, EXGSD, HTAAD ... NBOZA, NPHRA, NROAM, NAAOM, BDOPA, BANAA, BPSAC, BZIZA). |
| ROWE | Benjamin Rowe, *Enochian Temples* (1992), sacred-texts.com. | https://sacred-texts.com/eso/enoch/enochtmp.txt | Earth kerubic names BOZA, PHRA, OCNC, ASMT and NBOZA, NPHRA, NOCNC, NASMT. |
| ROWE_SENIORS | Benjamin Rowe, *The Book of the Seniors*. | http://www.rahoorkhuit.net/library/enochian/book_of_the_seniors.html | Earth: ICZHIHAL, LAIDROM, ACZINOR, LZINOPO, ALHCTGA, LIIANSA, AHMLICV. |
| AZ0TH | "Az0th", `table.dif`: diff of names computed from the Tabula Recensa vs Dee's Sloane 3191 names. | https://anna.lysator.liu.se/pub/magick/Enochian/Enochian_pgm/table.dif | Independent recomputation from the Recensa (confirms several grid rows and the derived forms TNBR, XGSD, NPNT, SONIZNT, OBGOTA, AABCO, ICZHIHAL, LIIANSA, AHMLICV, ABALPT, OPMNIR, ILPIZ, MSAP, OCNC, ASMT, ALNDVOD). Not counted as an independent "published" source in the verified count. |

Context only (not used as evidence):
- https://www.arcane-archive.org/occultism/magic/ceremonial/enochian/enochian-double-letters-1.php (Stenwick 1994: the Recensa has one letter per square; GD double letters merge versions).
- https://enochian.blog/posts/reconstructing-the-true-great-table/ (modern reconstruction; not used).
- http://vialarp.org/GD/practice_6_enochian_2.html (GD primer). **Rejected**: it calls OIP TEAA PDOCE the Air names and lists wrong Earth seniors (ASMAIHL, VCLBMCA, MORDIAL).

Could not access: hermetic.com (403 for Liber Chanokh, Ben Rowe's *Enochian Magick Reference*, *The Enochian Hierarchy*), sacred-texts.com/oto/lib84.htm (blocked). Regardie's *The Golden Dawn* plates are in copyright and were not consulted.

## Grid verification summary

### 1587 Tabula Recensa (`recensa1587`)
PETERSON vs KONDOR, all 624 squares: they agree everywhere (U/V and case ignored) except
- **Air row 12 col 1**: PETERSON `b` (S**b**ial), KONDOR `h`. TFR 1584, CROWLEY, BOOKH and Dee's name SHAL all have `h`. Kept as `b` in `recensa1587` with `unverified: true`; the GD set uses `H`.
- Air row 3 col 8: PETERSON's text copy has a typo `q`; his MS image shows `a`, as does KONDOR. `a` used.
AZ0TH's table prints 14 full Recensa rows (Air 0, 3, 7, 10; Water 1, 2, 5, 8, 10, 12; Earth 7, 8, 9; Fire 2); all 14 match PETERSON letter for letter.

### Golden Dawn set (`goldenDawn`)
Recensa letters, plus Air r12c1 = H. Squares where GD-lineage sources print something else
(each listed in `cellNotes` with every reading):

| Tablet | Square (row,col) | Chosen | CROWLEY | BOOKH | 1584 | Effect |
|---|---|---|---|---|---|---|
| Air | 0,7 | Y | y | y/u | u | Water-of-Air kerubic YTPA vs UTPA (GDCONS EYTPA, BOOKH EUTPA) |
| Air | 3,5 | Z | x | z/x | x | Senior AAOZAIF vs AAOXAIF (Dee, BOOKH x; GDCONS, KONDOR z) |
| Air | 7,0 | T | c | t/c | c | Kerubic TNBR vs CNBR (GDCONS ETNBR, BOOKH ECNBR) |
| Air | 7,4 | R | a | r/a | r | same name |
| Air | 7,10 | S | z | s/z | z | Kerubic XGSD vs XGZD (GDCONS EXGSD, BOOKH EXGZD) |
| Air | 10,10 | N | a | u/a | a | Servient NPNT vs NPAT (Dee NPAT) |
| Water | 1,2 | B | l | b/l | l | OBGOTA/AABCO vs OLGOTA/AALCO (Crowley); Dee's MS has L written under B |
| Water | 2,6-8 | X M A | z i n | x/z m/i a/u | x m a | Servient MAGM (Dee) vs INGM (Crowley) |
| Water | 3,8 | E | a | l/a | e | Servient LEOC vs LAOC |
| Water | 8,5 | N | a | n/a | a | Senior SONIZNT (GDCONS) vs SOAIXNT/SOAIZNT (Dee, KONDOR, CROWLEY) |
| Water | 10,5 | Z | z | z/x | z | same senior (x in Dee and TFR) |
| Earth | 7,0-11 | OCANCHIASOMT | R O a n c c h i a s o m | 2-3 letters per square | R O c a n c h i a s o m | King ICZHIHAL vs ICZHHCAL; seniors LIIANSA/LHIANSA, AHMLICV/ACMLICU; kerubic OCNC vs ROAN/ROAM, ASMT vs IAOM/AAOM/TAOM |
| Earth | 9,5 | L | B | l/B | B | Senior AHMLICV vs AHMBICV |
| Earth | 9,11 | P | L | T/L | L | Servient MSAP vs MSAL (Dee), MSAT (KONDOR) |
| Fire | 1,11 | A | a | a/i | a (TFR i) | OBAUA vs OBAVI (KONDOR) |
| Fire | 2,6 | V | O | V/O | O | Senior ALNDVOD vs ALNDOOD (Dee) |

Smaller one-off differences (Crowley Fire r3c1 `b`, r4c4 `a`, etc.) are in `cellNotes`; they look like typesetting slips.

### 1584 original (`dee1584`)
KONDOR's 1584 grid vs TFR 1659 scans: 608 of 624 squares agree, 12 disagree, 4 are illegible in the scan. Disagreements, all flagged `unverified`:
Air r2c6 (r / TFR v); Earth r7c0 (R / TFR Æ: a reversed letter); Earth r9c5 (B / TFR l); Fire r1c11 (a / TFR i);
Fire r12c6 (P / TFR Q: reversed P); Water r1c0 (o / a), r1c2 (l / b), r2c1 (a / o), r4c2 (t / c), r5c4 (z / x), r10c5 (z / x), r12c3 (n / i).
Illegible in the TFR scan (single-source): Fire r0c11, r1c10, Water r4c11, r12c11 (both reversed letters; Casaubon prints `yl` and `J`).
KONDOR's 1584 grid seems to include Dee's later corrections; TFR prints the first dictation.

### Tablet of Union
EXARP / HCOMA / NANTA / BITOM: BOOKH table, CROWLEY note 10, KONDOR, PETERSON image (black cross). No disagreement.

## Name-level discrepancies worth showing in the app

| Name | Readings | Choice in derived_names.json |
|---|---|---|
| Earth King | ICZHIHAL (ROWE_SENIORS, AZ0TH; KONDOR "Ikzhikal"), ICZHHCAL (CROWLEY; GD consecration "IC ZOD HEH CHAL"), Dee ICZHHCA / ICZHHCL | ICZHIHAL from the Recensa grid, `unverified` |
| Air senior 2 | AAOZAIF (GDCONS, KONDOR) / AAOXAIF (Dee, BOOKH) | AAOZAIF, verified |
| Water senior 2 | SAIINOV (CROWLEY, KONDOR, Dee SAIINOU) / SAIINOR (GDCONS) | SAIINOV, verified |
| Water senior 5 | SONIZNT (GDCONS) / SOAIXNT (Dee, KONDOR) / SOAIZNT (CROWLEY) | SONIZNT, `unverified` |
| Earth senior 5 | AHMLICV (ROWE_SENIORS) / AHMLLICV (GDCONS) / ACMLICU (Dee) | AHMLICV, `unverified` |
| Earth senior 6 | LIIANSA (GDCONS, ROWE_SENIORS) / LHIANSA (Dee, KONDOR) | LIIANSA, verified |
| Earth senior 4 | ALHCTGA (Dee, KONDOR, ROWE_SENIORS) / ALPHCTGA (GDCONS, extra letter) | ALHCTGA, verified |
| Fire senior 1 | AAETPIO (Dee, KONDOR) / AAETPOI (GDCONS) | AAETPIO, verified |
| Fire senior 3 | ALNDVOD (GDCONS) / ALNDOOD (Dee) / ALNKVOD (KONDOR) | ALNDVOD, `unverified` |
| Water, Air sub-angle cross | OBGOTA / AABCO (Dee MS, BOOKH AABCO) vs OLGOTA / AALCO (CROWLEY) | OBGOTA `unverified` (only Dee's MS and AZ0TH); AABCO verified |
| Water, Earth sub-angle horizontal | OLAAD (Dee, BOOKH, KONDOR) / OCAAD (CROWLEY text; his own plate reads OLAAD) | OLAAD, verified |
| Earth kerubic (Earth / Fire sub-angles) | NOCNC, NASMT (ROWE) / NROAM, NAAOM (GDCONS) / NTAOM (BOOKH) / HROAN, HIAOM (Dee) | NOCNC, NASMT, `unverified` |

## Notes on direction attributions
GD: Air = East, Water = West, Earth = North, Fire = South (Book H calls the tablets East, West, North, South quadrangles;
GD consecration ritual). Dee's own Sloane 3191 lists label the Earth tablet (MOR DIAL HCTGA) MERIDIES (South) and the
Fire tablet (OIP TEAA PDOCE) SEPTENTRIO (North). Kondor.de adds that Dee's angels gave other element/colour schemes.
Both are recorded in `tablets.json` (`directionGD`, `directionDee1587MS`).
