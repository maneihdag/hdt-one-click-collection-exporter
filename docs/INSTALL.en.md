# Installation — English

## Requirements

- Windows
- Hearthstone Deck Tracker installed
- Hearthstone installed

## Install

1. Open Hearthstone Deck Tracker and leave it running.
2. Run `INSTALL_PLUGIN_EN.bat`.
3. The installer detects the active/latest HDT installation and compiles the plugin against the HDT assemblies installed on your machine.
4. Fully close HDT, including the tray icon.
5. Reopen HDT.
6. Go to `Options > Tracker > Plugins`.
7. Enable `HDT One-Click Collection Exporter`.

The plugin DLL is installed to:

```text
%AppData%\HearthstoneDeckTracker\Plugins\HdtOneClickCollectionExporter.dll
```

## Export

1. Open Hearthstone.
2. Reach the main menu.
3. Keep HDT running.
4. Run `EXPORT_COLLECTION_EN.bat`.

## Troubleshooting

### Plugin does not appear

- Fully restart HDT, including its tray icon.
- Confirm the DLL exists in the plugin folder.
- If Windows shows an **Unblock** option in the DLL Properties dialog, use it.

### Export times out

Check that Hearthstone and HDT are open, the plugin is enabled, and Hearthstone has reached the main menu.

### Compilation fails

Open an issue with your HDT version, Windows version and the complete installer output.

Do not post credentials, tokens, cookies or private collection exports in issues.
