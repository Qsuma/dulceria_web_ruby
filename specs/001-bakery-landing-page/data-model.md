# Data Model: Bakery Landing Page

No database tables or ActiveRecord models are introduced for this feature (see
[research.md](./research.md) — Storage decision). Content is represented as plain Ruby view
objects backed by a YAML config file.

## BakeryProfile

Represents the business being presented on the page.

| Field | Type | Notes |
|---|---|---|
| `name` | String | "Dulces Lore" |
| `tagline` | String | Short descriptive summary shown near the name |
| `whatsapp_number` | String | Loaded from `ENV["WHATSAPP_CONTACT_NUMBER"]`, not from YAML (kept out of source-controlled config) |
| `whatsapp_greeting` | String | Fixed value: "Hola, quisiera más información sobre sus productos." |
| `address` | String | Physical address to display |
| `business_hours` | String | Human-readable hours (e.g., "Lun–Sáb 9:00–19:00") |
| `social_media_status` | String | Fixed value: "coming soon" indicator, no live links |

Validation rules:
- `name`, `whatsapp_number` are required for the page to render meaningfully; if
  `whatsapp_number` is missing, the app MUST raise a clear configuration error at boot/request
  time rather than silently render a broken link (fail-fast, no silent data corruption).

## ProductHighlight

Represents a featured product shown on the page.

| Field | Type | Notes |
|---|---|---|
| `name` | String | Product name |
| `description` | String | Short description |
| `image_path` | String (optional) | Path under `app/assets/images/`; page must gracefully omit the image if absent or fails to load (per Edge Cases in spec.md) |

Validation rules:
- At least one `ProductHighlight` MUST exist for the products section to render (FR-002).

## Relationships

- `BakeryProfile` has many `ProductHighlight` entries (one-to-many, config-defined, not
  persisted/foreign-keyed since there is no database).

## State Transitions

None — this is static, non-transactional content for the current scope (no ordering, no CRUD).
