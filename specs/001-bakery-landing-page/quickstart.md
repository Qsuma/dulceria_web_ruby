# Quickstart: Bakery Landing Page

## Prerequisites

- Ruby (version matching `.ruby-version` once the Rails app is generated, e.g., 3.2+)
- Bundler
- `.env` file at the repo root with `WHATSAPP_CONTACT_NUMBER` set (already present)

## Setup

```bash
bundle install
```

## Run

```bash
bin/rails server
```

Visit `http://localhost:3000/` in a browser.

## Validate the feature end-to-end

1. **Content in Spanish**: Confirm the bakery name ("Dulces Lore"), tagline, product
   descriptions, address, hours, and WhatsApp button label are all in Spanish (SC-002).
2. **WhatsApp contact link**: Click/tap the WhatsApp button.
   - On mobile (or a mobile viewport in dev tools): confirm it opens/attempts to open the
     WhatsApp app with the configured number and the greeting
     "Hola, quisiera más información sobre sus productos." pre-filled.
   - On desktop: confirm it opens WhatsApp Web (or prompts for the desktop app) with the same
     number and greeting.
   - Verify the link is reachable within 5 seconds of page load without scrolling far (SC-001).
3. **Responsive layout**: Resize the browser to a common mobile width (e.g., 375px) and a common
   desktop width (e.g., 1440px) and confirm no horizontal scrolling or broken layout (SC-003).
4. **Social media section**: Confirm a "redes sociales próximamente" (coming soon) section is
   visible with no clickable/live social media links.
5. **Missing WhatsApp number**: Temporarily unset `WHATSAPP_CONTACT_NUMBER` and confirm the app
   fails fast with a clear configuration error rather than rendering a broken link, then restore
   the variable.

## Tests

```bash
bundle exec rspec spec/requests/bakery_page_spec.rb
```

Expected: all request specs pass, covering the scenarios above (see
[contracts/page.md](./contracts/page.md) and [data-model.md](./data-model.md) for the exact
content/link requirements each test verifies).
