# Derivation rules (Golden Dawn method, with Dee's differences noted)

All coordinates are **0-based**: `row 0` is the top row, `col 0` the leftmost square of one 12 x 13 tablet
(the tablet on its own, without the Black Cross). `g[r][c]` = letter at row r, column c.
`derive.py` in `work/` implements exactly these rules; `derived_names.json` is its output.

## 1. The Great Central Cross of a tablet

| Line | Where | Source wording |
|---|---|---|
| Linea Patris (Line of the Father) | column 5 | Crowley: "The 6th file is called Linea Patris" |
| Linea Filii (Line of the Son) | column 6 | "The 7th file is called Linea Filii" |
| Linea Spiritus Sancti (Line of the Holy Spirit) | row 6 | "The 7th line is called Linea Spiritus Sancti" |

The cross splits the tablet into four sub-angles (lesser angles), each 6 rows x 5 columns:

| Sub-angle (GD element) | Rows | Columns |
|---|---|---|
| top-left = Air of [tablet] | 0-5 | 0-4 |
| top-right = Water of [tablet] | 0-5 | 7-11 |
| bottom-left = Earth of [tablet] | 7-12 | 0-4 |
| bottom-right = Fire of [tablet] | 7-12 | 7-11 |

(Crowley, Liber Chanokh: "the left-hand top corner being Air of Air, the right-hand top corner Water of Air,
the left-hand bottom corner Earth of Air, the remaining corner Fire of Air." The same layout holds for every tablet.)

## 2. Three Holy Names of God

Read row 6 left to right and cut it 3 + 4 + 5:
`g[6][0..2]`, `g[6][3..6]`, `g[6][7..11]`.
Air: ORO IBAH AOZPI. Water: MPH ARSL GAIOL. Earth: MOR DIAL HCTGA. Fire: OIP TEAA PDOCE.
(TFR p.177; Book H; Crowley.)

## 3. Great King (whirl around the centre)

Eight letters, in this order:

```
g[6][4]  g[5][5]  g[5][6]  g[6][7]  g[7][6]  g[7][5]  g[6][5]  g[6][6]
```

i.e. start left of the centre on row 6, go up-left, up-right, right of the centre on row 6,
down-right, down-left, and finish with the two centre squares (col 5 then col 6 of row 6).
Air gives B-A-T-A-I-V-A-H.

Dee's rule (TFR p.178, repeated in Book H): the King has **7** letters. The last letter is
EITHER the centre `A` (g[6][5]) "comiter" (in mercy) OR the centre `h` (g[6][6]) "in extremis judiciis":
BATAIVA or BATAIVH. Dee's Sloane 3191 lists give the same pairs (RAAGIOS/RAAGIOL, ICZHHCA/ICZHHCL, EDLPRNA).
The Golden Dawn writes both letters, giving 8-letter names (BATAIVAH, RAAGIOSL, ICZHIHAL, EDLPRNAA).

## 4. Six Seniors

Each starts at one of the two centre squares of row 6 and runs out to the edge, 7 letters each.

| # | Name (Air example) | Squares | GD planet |
|---|---|---|---|
| 1 | HABIORO | `g[6][6]`, then `g[6][5]` -> `g[6][0]` (leftward) | Mars |
| 2 | AAOZAIF | `g[6][5]` -> `g[0][5]` (up col 5) | Jupiter |
| 3 | HTMORDA | `g[6][6]` -> `g[0][6]` (up col 6) | Luna |
| 4 | AHAOZPI | `g[6][5]`, then `g[6][6]` -> `g[6][11]` (rightward) | Venus |
| 5 | AVTOTAR | `g[6][5]` -> `g[12][5]` (down col 5) | Mercury |
| 6 | HIPOTGA | `g[6][6]` -> `g[12][6]` (down col 6) | Saturn |

Seniors 1 and 4 "borrow" the other centre letter as their first letter. Dee gives 6- and 7-letter forms
(ABIORO / HABIORO, HAOZPI / AHAOZPI); GD always uses 7. Planet attributions are GD only
(kondor.de and vialarp.org agree on them); Dee gives none.

## 5. Calvary Cross names (one pair per sub-angle)

For a sub-angle whose top-left square is `(r0, c0)` (r0 in {0, 7}, c0 in {0, 7}):

- **Calling name, 6 letters (vertical):** `g[r0..r0+5][c0+2]`, read top to bottom.
  Air of Air: IDOIGO.
- **Commanding name, 5 letters (horizontal):** `g[r0+1][c0..c0+4]`, read left to right.
  Air of Air: ARDZA.

TFR p.177: "in the upper left angle in the second line a r d z a ... the crosse downward: first i, then the same d, o, i, g, o."
Book H: the vertical name "calleth forth"; the horizontal one makes them "do what they are commanded".

## 6. Kerubic angels (4 per sub-angle)

Take the four squares of the sub-angle's top row that are NOT under the vertical bar:
`g[r0][c0], g[r0][c0+1], g[r0][c0+3], g[r0][c0+4]` -> first name (Air of Air: RZLA).
The other three are rotations: move the first letter to the end each time.
RZLA -> ZLAR -> LARZ -> ARZL. (TFR p.178; Book H; Dee's Sloane 3191 list.)

### Prefix for the kerubic ruling name

- **GD rule:** prefix the first letter of the tablet's Tablet-of-Union line
  (Air **E** of EXARP, Water **H** of HCOMA, Earth **N** of NANTA, Fire **B** of BITOM)
  to the FIRST kerubic name. This is one name of God (GD "archangel") ruling the four kerubim:
  ERZLA, HTDIM, NBOZA, BZIZA... (Book H; GD Consecration of the Elemental Weapons.)
- Some modern GD writers prefix all four rotations (ERZLA, EZLAR, ELARZ, EARZL). That form is
  listed as `kerubicAngels_eachPrefixed_modernGDvariant` and marked unverified.
- **Dee's rule (different):** prefix the Black-Cross letter that sits on the same row as the kerubic row
  in the 1584 Great Table. That is why Dee writes ATAAD, ATDIM, HCNBR, PZIZA where GD has HTAAD, HTDIM, ECNBR/ETNBR, BZIZA.
  (Crowley/Celephaïs note 10; Az0th table.dif; Dee's Sloane 3191 list.)

## 7. Servient (lesser) angels (4 per sub-angle)

The four rows under the commanding-name row, skipping the vertical-bar column:
for `r = r0+2 .. r0+5`: `g[r][c0] g[r][c0+1] g[r][c0+3] g[r][c0+4]`.
Air of Air: CZNS, TOTT, SIAS, FMND.
(Dee also gives 5-letter forms that keep the bar letter: CZONS, TOITT, SIGAS, FMOND.)

### Prefix for servient names (GD)

Use the tablet's Tablet-of-Union line; the letter depends on the sub-angle:

| Sub-angle | Letter of the line | Air tablet (EXARP) | Water (HCOMA) | Earth (NANTA) | Fire (BITOM) |
|---|---|---|---|---|---|
| Air of ... | 2nd | X | C | A | I |
| Water of ... | 3rd | A | O | N | T |
| Earth of ... | 4th | R | M | T | O |
| Fire of ... | 5th | P | A | A | M |

So Air of Air gives XCZNS, XTOTT, XSIAS, XFMND. (Celephaïs note 10 to Liber Chanokh states this as the
GD rule; kondor.de lists all 64.) Only kondor.de prints the full prefixed lists, so these are at best `supported`.

Careful: Book H and Dee use the Tablet-of-Union / Black-Cross letters differently. They take the four
letters **row by row** inside one sub-angle (Air of Air: X + cz = XCZ, A + to = ATO, R + si = RSI, P + fm = PFM)
and only for the three-letter cacodemon names, not as prefixes to the servient angels.
The per-sub-angle prefix table above is the later GD (Regardie-era) convention.

## 8. Three-letter names (not exported; listed for completeness)

Book H / Dee: two adjacent servient letters on one side of the vertical bar, plus one Tablet-of-Union
letter (GD) or Black-Cross letter (Dee), give the name of a cacodemon (XCZ, ATO ...). The calling and
commanding names read backwards (OGIODI, AZDRA) govern them.

## 9. Tablet of Union

```
E X A R P
H C O M A
N A N T A
B I T O M
```

Rows: Air, Water, Earth, Fire. GD columns: Spirit, Air, Water, Earth, Fire.
The letters are the Black Cross of the Great Table. Read as words they are
LEXARPH, COMANAN, TABITOM (the three governors of the 10th Aethyr ZAX) with the first L left out
(kondor.de; Crowley/Celephaïs note to the Aethyr list).

## 10. Letter equivalences

Treat these as one letter when comparing: U = V, I = Y (Dee's alphabet has one letter for each pair).
C and K are one letter too; some writers (Schueler, kondor.de) spell C as K (IKZHIKAL = ICZHIHAL).
The Dee manuscripts mix capitals and small letters; this has no known meaning for the derivations.

## Verification status used in derived_names.json

- `verified`: 2 or more independent printed sources give the same spelling (Az0th's recomputation does not count toward the 2).
- `supported`: 1 printed source agrees AND every square used is stable (Peterson and kondor agree on it, and no GD-lineage source prints another letter there).
- `unverified` (`"unverified": true`): anything else. `uncertainSquares` names the squares that cause doubt.
