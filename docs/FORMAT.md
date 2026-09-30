# Export format

Schema version: `1`.

## Top-level structure

```json
{
  "format_version": 1,
  "exported_at": "2026-09-30T10:00:00Z",
  "source": "Hearthstone Deck Tracker",
  "dust": 420,
  "collection": {},
  "favorite_heroes": {},
  "cardbacks": [],
  "favorite_cardback": 0,
  "player_records": {},
  "summary": {}
}
```

## `collection`

Keys are Hearthstone DBF IDs.

Each value contains exactly four counts:

```text
[normal, golden, diamond, signature]
```

Example:

```json
"12345": [2, 1, 0, 0]
```

Cards whose four counts sum to zero are omitted.

## `summary`

Example:

```json
{
  "unique_owned_dbf_ids": 4,
  "normal": 3,
  "golden": 1,
  "diamond": 1,
  "signature": 1,
  "total_owned": 6
}
```

## Privacy-conscious omissions

The public schema intentionally does not export:

- BattleTag
- account_hi
- account_lo
- browser/session data
- OAuth tokens
