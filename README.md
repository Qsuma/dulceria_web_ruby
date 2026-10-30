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

## Deploy on Render

This Rails application runs on a Ruby web server and is not a static Vercel
deployment. To deploy it on Render:

1. Push this repository to GitHub and create a Blueprint on Render from it.
   Render will use `render.yaml` to build and start the web service.
2. Set `WHATSAPP_CONTACT_NUMBER` in the service's environment variables to the
   bakery's WhatsApp number, including the country code.
3. Open the public URL shown on the Render service after the first deploy.
