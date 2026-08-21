# Dulceria Web Ruby — Dulces Lore Landing Page

A Ruby on Rails landing page for the "Dulces Lore" bakery, in Spanish, with a WhatsApp contact
button.

## Setup

1. Install Ruby (see `.ruby-version`) and Bundler.
2. `bundle install`
3. Ensure a `.env` file exists at the repo root with:

   ```
   WHATSAPP_CONTACT_NUMBER=+<country code and number, digits and optional spaces/symbols>
   ```

   This is required — the app raises a clear error on boot/request if it's missing.
4. `bin/rails server` and visit `http://localhost:3000/`.

## Tests

```
bundle exec rspec
```

See [specs/001-bakery-landing-page/quickstart.md](specs/001-bakery-landing-page/quickstart.md)
for full end-to-end validation steps.
