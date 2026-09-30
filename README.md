# HDT One-Click Collection Exporter

> One-click local JSON export for your Hearthstone collection from Hearthstone Deck Tracker (HDT).  
> Esportazione locale JSON con un clic della tua collezione di Hearthstone da Hearthstone Deck Tracker (HDT).

![Platform](https://img.shields.io/badge/platform-Windows-blue)
![HDT Plugin](https://img.shields.io/badge/HDT-plugin-orange)
![License](https://img.shields.io/badge/license-MIT-yellow)
![Languages](https://img.shields.io/badge/docs-English%20%7C%20Italian-green)
![Status](https://img.shields.io/badge/status-v1.0.0%20tested-brightgreen)

**Current status:** v1.0.0 has been tested end-to-end with HDT 1.58.5: install → plugin load → local export → JSON validation.

## English

### What it does

**HDT One-Click Collection Exporter** saves the Hearthstone collection already available inside HDT as a compact local JSON file.

It is designed for people who want a reusable collection snapshot without opening browser developer tools or building an API/OAuth workflow.

Useful for:

- local collection backups;
- deck-building and collection-analysis tools;
- spreadsheets and personal scripts;
- AI / LLM-assisted collection analysis;
- comparing collection snapshots over time;
- local-first workflows.

### Highlights

- **One-click export** from a `.bat` launcher.
- Reads the collection directly from HDT.
- **No browser automation.**
- **No HSReplay OAuth token handling.**
- **No web scraping.**
- **No network request is made by this plugin during export.**
- Compact JSON: cards with zero owned copies are omitted.
- Normal, golden, diamond and signature counts.
- Automatic timestamped local archive.
- English and Italian installers/export launchers.
- Privacy-conscious public schema: BattleTag and Blizzard account identifiers are omitted.

### How it works

```text
Hearthstone → Hearthstone Deck Tracker → local HDT plugin → HDT_Collection.json
```

The installer compiles the small plugin locally against the HDT assemblies already installed on your PC. The export itself stays local.

### Requirements

- Windows
- Hearthstone
- [Hearthstone Deck Tracker](https://github.com/HearthSim/Hearthstone-Deck-Tracker)

### Quick install

1. Download or clone this repository.
2. Open Hearthstone Deck Tracker and leave it running.
3. Run `INSTALL_PLUGIN_EN.bat`.
4. Fully close HDT, including its tray icon.
5. Reopen HDT.
6. Go to `Options > Tracker > Plugins`.
7. Enable **HDT One-Click Collection Exporter**.

Detailed guide: [docs/INSTALL.en.md](docs/INSTALL.en.md)

### Export

1. Open Hearthstone and reach the main menu.
2. Keep HDT running.
3. Double-click `EXPORT_COLLECTION_EN.bat`.

Output:

```text
Desktop\HDT_Collection.json
Desktop\HDT Collection Archive\HDT_Collection_YYYY-MM-DD_HH-MM-SS.json
```

You can also use **Export now / Esporta ora** directly from the plugin entry in HDT.

### JSON format

Each owned card is keyed by Hearthstone DBF ID:

```json
"12345": [2, 1, 0, 0]
```

Meaning:

```text
[normal, golden, diamond, signature]
```

Cards with zero owned copies are omitted.

See [docs/FORMAT.md](docs/FORMAT.md).

### Privacy

The export is local.

The default public schema does **not** include:

- BattleTag
- Blizzard account hi/lo identifiers
- browser cookies
- HSReplay OAuth tokens

The file can still contain collection/gameplay information such as dust and HDT player records. Review an export before sharing it publicly.

See [docs/PRIVACY.md](docs/PRIVACY.md).

---

## Italiano

### Cosa fa

**HDT One-Click Collection Exporter** salva in un file JSON locale e compatto la collezione di Hearthstone già letta da HDT.

È pensato per chi vuole uno snapshot riutilizzabile della propria collezione senza aprire gli strumenti sviluppatore del browser e senza creare un flusso API/OAuth.

È utile per:

- backup locali;
- strumenti di deck building e analisi;
- fogli di calcolo e script personali;
- analisi della collezione con AI / LLM;
- confronto tra snapshot nel tempo;
- workflow local-first.

### Caratteristiche

- **Esportazione con un clic** tramite `.bat`.
- Lettura diretta dalla collezione disponibile in HDT.
- **Nessuna automazione del browser.**
- **Nessuna gestione di token OAuth HSReplay.**
- **Nessuno scraping web.**
- **Nessuna richiesta di rete effettuata dal plugin durante l'export.**
- JSON compatto: le carte con zero copie vengono escluse.
- Copie normali, dorate, diamond e signature.
- Archivio locale automatico con data e ora.
- Installer e launcher in inglese e italiano.
- Il formato pubblico omette BattleTag e identificativi Blizzard.

### Installazione rapida

1. Scarica o clona il repository.
2. Apri Hearthstone Deck Tracker e lascialo aperto.
3. Avvia `INSTALLA_PLUGIN_IT.bat`.
4. Chiudi completamente HDT, anche dalla tray.
5. Riapri HDT.
6. Vai in `Options > Tracker > Plugins`.
7. Abilita **HDT One-Click Collection Exporter**.

Guida completa: [docs/INSTALL.it.md](docs/INSTALL.it.md)

### Esportazione

1. Apri Hearthstone e arriva al menu principale.
2. Lascia HDT aperto.
3. Avvia `ESPORTA_COLLEZIONE_IT.bat`.

Output:

```text
Desktop\HDT_Collection.json
Desktop\HDT Collection Archive\HDT_Collection_YYYY-MM-DD_HH-MM-SS.json
```

Puoi anche usare **Export now / Esporta ora** direttamente dalla voce del plugin dentro HDT.

---

## Project status

`v1.0.0` — first public version, tested end-to-end with HDT 1.58.5.

### Roadmap

Possible future additions:

- precompiled release DLL;
- CSV export;
- optional minimal/private export mode;
- snapshot diff;
- card-name enrichment;
- automated release packaging;
- more languages.

## Contributing

Issues, bug reports, documentation improvements and pull requests are welcome.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Credits & disclaimer

Built for the Hearthstone Deck Tracker plugin ecosystem.

Hearthstone is a trademark of Blizzard Entertainment. Hearthstone Deck Tracker / HearthSim and HSReplay.net belong to their respective owners.

This is an independent community project and is not affiliated with or endorsed by Blizzard Entertainment, HearthSim, or HSReplay.net.

## License

MIT — see [LICENSE](LICENSE).
