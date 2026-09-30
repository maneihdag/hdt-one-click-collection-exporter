# Installazione — Italiano

## Requisiti

- Windows
- Hearthstone Deck Tracker installato
- Hearthstone installato

## Installazione

1. Apri Hearthstone Deck Tracker e lascialo aperto.
2. Avvia `INSTALLA_PLUGIN_IT.bat`.
3. L'installer rileva l'installazione HDT attiva/più recente e compila il plugin usando le librerie HDT presenti sul PC.
4. Chiudi completamente HDT, inclusa l'icona nella tray.
5. Riapri HDT.
6. Vai in `Options > Tracker > Plugins`.
7. Abilita `HDT One-Click Collection Exporter`.

Il DLL viene installato qui:

```text
%AppData%\HearthstoneDeckTracker\Plugins\HdtOneClickCollectionExporter.dll
```

## Esportazione

1. Apri Hearthstone.
2. Arriva al menu principale.
3. Lascia HDT aperto.
4. Avvia `ESPORTA_COLLEZIONE_IT.bat`.

## Risoluzione problemi

### Il plugin non compare

- Riavvia completamente HDT, inclusa la tray.
- Controlla che il DLL esista nella cartella Plugins.
- Se nelle Proprietà del DLL compare **Sblocca**, usalo.

### L'export va in timeout

Controlla che Hearthstone e HDT siano aperti, che il plugin sia abilitato e che Hearthstone sia arrivato al menu principale.

### La compilazione fallisce

Apri una issue indicando versione HDT, versione Windows e output completo dell'installer.

Non pubblicare credenziali, token, cookie o export privati nelle issue.
