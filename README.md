# HDT One-Click Collection Exporter

> One-click local JSON export for your Hearthstone collection from Hearthstone Deck Tracker (HDT).  
> Esportazione locale JSON con un clic della tua collezione di Hearthstone da Hearthstone Deck Tracker (HDT).

![Platform](https://img.shields.io/badge/platform-Windows-blue)
![HDT Plugin](https://img.shields.io/badge/HDT-plugin-orange)
![License](https://img.shields.io/badge/license-MIT-yellow)
![Languages](https://img.shields.io/badge/docs-English%20%7C%20Italian-green)
![Status](https://img.shields.io/badge/status-v1.0.0%20tested-brightgreen)

<p align="center">
  <a href="https://github.com/maneihdag/hdt-one-click-collection-exporter/releases/latest">
    <img src="https://img.shields.io/badge/Download-Latest%20Release-brightgreen?style=for-the-badge" alt="Download latest release">
  </a>
</p>

<p align="center">
  <a href="https://github.com/maneihdag/hdt-one-click-collection-exporter/releases/tag/v1.0.0">
    HDT One-Click Collection Exporter v1.0.0
  </a>
</p>

**Current status:** v1.0.0 has been tested end-to-end with Hearthstone Deck Tracker 1.58.5: installation → plugin load → local collection export → JSON validation.

<!--
Uncomment this section after uploading assets/demo.gif

## Demo

<p align="center">
  <img src="assets/demo.gif" alt="HDT One-Click Collection Exporter demo" width="850">
</p>
-->

---

# English

## Quick start

1. Download the [latest release](https://github.com/maneihdag/hdt-one-click-collection-exporter/releases/latest) or the repository ZIP.
2. Extract the archive.
3. Open **Hearthstone Deck Tracker** and leave it running.
4. Run:

```text
INSTALL_PLUGIN_EN.bat
```

5. Fully close HDT, including its tray icon.
6. Reopen HDT.
7. Go to:

```text
Options > Tracker > Plugins
```

8. Enable:

```text
HDT One-Click Collection Exporter
```

9. Open Hearthstone and reach the main menu.
10. Run:

```text
EXPORT_COLLECTION_EN.bat
```

Your collection will be saved to:

```text
Desktop\HDT_Collection.json
```

A timestamped backup is also created automatically in:

```text
Desktop\HDT Collection Archive\
```

---

## What it does

**HDT One-Click Collection Exporter** saves the Hearthstone collection already available inside Hearthstone Deck Tracker as a compact local JSON file.

It is designed for people who want a reusable collection snapshot without opening browser developer tools or building an API/OAuth workflow.

Useful for:

- local collection backups;
- deck-building tools;
- collection-analysis tools;
- spreadsheets and personal scripts;
- AI / LLM-assisted collection analysis;
- comparing collection snapshots over time;
- local-first workflows.

---

## Highlights

- **One-click local collection export**
- Reads collection data directly from Hearthstone Deck Tracker
- **No browser automation**
- **No HSReplay OAuth token handling**
- **No web scraping**
- **No network request is made by the plugin during export**
- Compact JSON output
- Cards with zero owned copies are omitted
- Normal card counts
- Golden card counts
- Diamond card counts
- Signature card counts
- Automatic timestamped local archive
- English and Italian installers
- English and Italian export launchers
- Privacy-conscious public export format
- Squirrel-based HDT installations supported

---

## How it works

```text
Hearthstone
     ↓
Hearthstone Deck Tracker
     ↓
HDT One-Click Collection Exporter
     ↓
HDT_Collection.json
```

The installer compiles the small plugin locally against the Hearthstone Deck Tracker assemblies already installed on your PC.

The export itself stays local.

---

## Requirements

- Windows
- Hearthstone
- [Hearthstone Deck Tracker](https://github.com/HearthSim/Hearthstone-Deck-Tracker)

Tested end-to-end with:

```text
Hearthstone Deck Tracker 1.58.5
```

Other HDT versions may also work, but compatibility has not yet been verified for every release.

---

## Installation

1. Download or clone this repository.
2. Open Hearthstone Deck Tracker and leave it running.
3. Run:

```text
INSTALL_PLUGIN_EN.bat
```

4. The installer detects the compatible managed HDT assembly installed on your system.
5. The plugin is compiled locally.
6. Fully close HDT, including its tray icon.
7. Reopen HDT.
8. Go to:

```text
Options > Tracker > Plugins
```

9. Enable:

```text
HDT One-Click Collection Exporter
```

Detailed guide:

[docs/INSTALL.en.md](docs/INSTALL.en.md)

---

## Export your collection

Open Hearthstone and reach the main menu.

Keep Hearthstone Deck Tracker running, then double-click:

```text
EXPORT_COLLECTION_EN.bat
```

If the export succeeds, the launcher will display:

```text
EXPORT COMPLETED
```

The current collection is saved to:

```text
Desktop\HDT_Collection.json
```

A timestamped archive copy is also created:

```text
Desktop\HDT Collection Archive\HDT_Collection_YYYY-MM-DD_HH-MM-SS.json
```

You can also trigger an export directly from the plugin entry inside HDT using:

```text
Export now / Esporta ora
```

---

## JSON format

The exported collection is keyed by Hearthstone **DBF ID**.

Example:

```json
"12345": [2, 1, 0, 0]
```

Each array contains exactly four values:

```text
[normal, golden, diamond, signature]
```

So:

```json
"12345": [2, 1, 0, 0]
```

means:

- 2 normal copies
- 1 golden copy
- 0 diamond copies
- 0 signature copies

Cards whose total owned count is zero are omitted from the file.

The export also contains a summary section with totals.

Example:

```json
{
  "unique_owned_dbf_ids": 3729,
  "normal": 6727,
  "golden": 1397,
  "diamond": 2,
  "signature": 52,
  "total_owned": 8178
}
```

Full format documentation:

[docs/FORMAT.md](docs/FORMAT.md)

---

## Example output

```json
{
  "format_version": 1,
  "exported_at": "2026-09-30T10:20:09Z",
  "source": "Hearthstone Deck Tracker",
  "dust": 75,
  "collection": {
    "7": [
      1,
      0,
      0,
      0
    ],
    "8": [
      2,
      2,
      0,
      0
    ]
  },
  "favorite_heroes": {},
  "cardbacks": [],
  "favorite_cardback": 0,
  "player_records": {},
  "summary": {
    "unique_owned_dbf_ids": 2,
    "normal": 3,
    "golden": 2,
    "diamond": 0,
    "signature": 0,
    "total_owned": 5
  }
}
```

The repository also contains a synthetic example file:

[samples/sample-collection.json](samples/sample-collection.json)

---

## Privacy

The export is performed locally.

The public export format intentionally does **not** include:

- BattleTag
- Blizzard account hi/lo identifiers
- browser cookies
- HSReplay OAuth tokens
- authentication credentials

The JSON can still contain information about your collection, dust and HDT player records.

Always review an export before sharing it publicly.

More information:

[docs/PRIVACY.md](docs/PRIVACY.md)

---

## Uninstall

Run:

```text
UNINSTALL_PLUGIN_EN.bat
```

Then restart Hearthstone Deck Tracker.

---

# Italiano

## Avvio rapido

1. Scarica l'[ultima release](https://github.com/maneihdag/hdt-one-click-collection-exporter/releases/latest) oppure lo ZIP del repository.
2. Estrai l'archivio.
3. Apri **Hearthstone Deck Tracker** e lascialo aperto.
4. Avvia:

```text
INSTALLA_PLUGIN_IT.bat
```

5. Chiudi completamente HDT, compresa l'icona nella tray.
6. Riapri HDT.
7. Vai in:

```text
Options > Tracker > Plugins
```

8. Abilita:

```text
HDT One-Click Collection Exporter
```

9. Apri Hearthstone e arriva al menu principale.
10. Avvia:

```text
ESPORTA_COLLEZIONE_IT.bat
```

La tua collezione verrà salvata in:

```text
Desktop\HDT_Collection.json
```

Viene inoltre creato automaticamente un archivio con data e ora in:

```text
Desktop\HDT Collection Archive\
```

---

## Cosa fa

**HDT One-Click Collection Exporter** salva in un file JSON locale e compatto la collezione di Hearthstone già disponibile all'interno di Hearthstone Deck Tracker.

È pensato per chi vuole ottenere uno snapshot riutilizzabile della propria collezione senza:

- aprire gli strumenti sviluppatore del browser;
- automatizzare il browser;
- gestire token OAuth;
- effettuare web scraping.

Può essere utile per:

- backup locali della collezione;
- strumenti di deck building;
- analisi della collezione;
- fogli di calcolo;
- script personali;
- analisi tramite AI / LLM;
- confronto della collezione nel tempo;
- workflow local-first.

---

## Caratteristiche

- **Esportazione locale con un clic**
- Lettura diretta dei dati disponibili in HDT
- **Nessuna automazione del browser**
- **Nessuna gestione di token OAuth HSReplay**
- **Nessuno scraping web**
- **Nessuna richiesta di rete effettuata dal plugin durante l'export**
- JSON compatto
- Le carte con zero copie vengono escluse
- Conteggio carte normali
- Conteggio carte dorate
- Conteggio carte Diamond
- Conteggio carte Signature
- Archivio locale automatico con data e ora
- Installer in inglese e italiano
- Launcher di esportazione in inglese e italiano
- Formato pubblico orientato alla privacy
- Supporto alle installazioni HDT basate su Squirrel

---

## Come funziona

```text
Hearthstone
     ↓
Hearthstone Deck Tracker
     ↓
HDT One-Click Collection Exporter
     ↓
HDT_Collection.json
```

L'installer compila localmente il piccolo plugin utilizzando le librerie di Hearthstone Deck Tracker già installate sul computer.

L'esportazione rimane locale.

---

## Requisiti

- Windows
- Hearthstone
- [Hearthstone Deck Tracker](https://github.com/HearthSim/Hearthstone-Deck-Tracker)

Testato completamente con:

```text
Hearthstone Deck Tracker 1.58.5
```

Altre versioni di HDT potrebbero funzionare, ma non sono ancora state verificate tutte.

---

## Installazione

1. Scarica o clona il repository.
2. Apri Hearthstone Deck Tracker e lascialo aperto.
3. Avvia:

```text
INSTALLA_PLUGIN_IT.bat
```

4. L'installer rileva automaticamente l'assembly HDT .NET utilizzabile installato sul computer.
5. Il plugin viene compilato localmente.
6. Chiudi completamente HDT, compresa l'icona nella tray.
7. Riapri HDT.
8. Vai in:

```text
Options > Tracker > Plugins
```

9. Abilita:

```text
HDT One-Click Collection Exporter
```

Guida completa:

[docs/INSTALL.it.md](docs/INSTALL.it.md)

---

## Esporta la collezione

Apri Hearthstone e arriva al menu principale.

Lascia Hearthstone Deck Tracker aperto e avvia:

```text
ESPORTA_COLLEZIONE_IT.bat
```

Se l'esportazione riesce, il launcher mostrerà:

```text
ESPORTAZIONE COMPLETATA
```

Il file principale viene salvato in:

```text
Desktop\HDT_Collection.json
```

Viene inoltre creata automaticamente una copia con data e ora:

```text
Desktop\HDT Collection Archive\HDT_Collection_YYYY-MM-DD_HH-MM-SS.json
```

Puoi anche avviare manualmente l'esportazione dalla voce del plugin dentro HDT tramite:

```text
Export now / Esporta ora
```

---

## Formato JSON

Le carte sono identificate tramite il loro **DBF ID** di Hearthstone.

Esempio:

```json
"12345": [2, 1, 0, 0]
```

I quattro valori rappresentano:

```text
[normali, dorate, diamond, signature]
```

Quindi:

```json
"12345": [2, 1, 0, 0]
```

significa:

- 2 copie normali
- 1 copia dorata
- 0 copie Diamond
- 0 copie Signature

Le carte con quantità totale pari a zero non vengono inserite nel JSON.

Documentazione completa:

[docs/FORMAT.md](docs/FORMAT.md)

---

## Privacy

L'esportazione avviene localmente.

Il formato pubblico non include:

- BattleTag
- identificativi Blizzard account hi/lo
- cookie del browser
- token OAuth HSReplay
- credenziali di autenticazione

Il JSON può comunque contenere informazioni relative alla tua collezione, alla polvere arcana e ai player records disponibili in HDT.

Controlla sempre il file prima di condividerlo pubblicamente.

Maggiori informazioni:

[docs/PRIVACY.md](docs/PRIVACY.md)

---

## Disinstallazione

Avvia:

```text
DISINSTALLA_PLUGIN_IT.bat
```

Poi riavvia Hearthstone Deck Tracker.

---

# Project status

**v1.0.0 — first public release**

Tested end-to-end with Hearthstone Deck Tracker 1.58.5.

Release:

[HDT One-Click Collection Exporter v1.0.0](https://github.com/maneihdag/hdt-one-click-collection-exporter/releases/tag/v1.0.0)

---

## Roadmap

Possible future improvements:

- precompiled plugin DLL;
- CSV export;
- optional minimal/private export mode;
- comparison between collection snapshots;
- card-name enrichment;
- automated release packaging;
- additional languages;
- improved compatibility testing across HDT versions.

---

## Contributing

Bug reports, documentation improvements, compatibility reports, feature suggestions and pull requests are welcome.

See:

[CONTRIBUTING.md](CONTRIBUTING.md)

Please do **not** post:

- tokens;
- cookies;
- credentials;
- private authentication information;
- unsanitized personal collection exports.

---

## Security

For security and privacy guidance, see:

[SECURITY.md](SECURITY.md)

---

## Credits & disclaimer

Built for the Hearthstone Deck Tracker plugin ecosystem.

Hearthstone is a trademark of Blizzard Entertainment.

Hearthstone Deck Tracker / HearthSim and HSReplay.net belong to their respective owners.

This is an independent community project and is **not affiliated with or endorsed by Blizzard Entertainment, HearthSim, or HSReplay.net**.

---

## License

MIT License.

See:

[LICENSE](LICENSE)
