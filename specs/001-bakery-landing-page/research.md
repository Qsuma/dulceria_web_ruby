# Research: Bakery Landing Page

## Decision: Rails version & app shape
- **Decision**: Ruby on Rails 8.1.3.1 with Ruby 4.0.5 (the toolchain already installed via rbenv
  in the development environment), generated with `rails new . --minimal --skip-test`. No
  database adapter is configured as a hard dependency since this feature needs none (see Storage
  decision below); the default SQLite adapter that ships with `rails new` is left in place for
  future features rather than removed, but is not used by this feature.
- **Rationale**: The project constitution mandates Ruby on Rails as the technology stack. Using
  the Rails/Ruby versions already installed avoids introducing a second toolchain version for a
  single landing page, and Rails 8.1 works with plain ERB views without requiring a frontend JS
  framework, keeping scope minimal.
- **Alternatives considered**: Sinatra (rejected — constitution specifies Rails); a static
  HTML/CSS site with no backend framework (rejected — conflicts with the constitution's
  Technology Constraints, which mandate Rails for the project regardless of a given feature's
  complexity).

## Decision: Storage for Bakery Profile & Product Highlights
- **Decision**: No database table/model. Bakery profile and product highlight content are stored
  as a single YAML config file (`config/bakery.yml`) loaded into a plain Ruby view model
  (`BakeryPresenter` or similar), not an ActiveRecord model.
- **Rationale**: Simplicity & YAGNI (Principle II) — the spec has no requirement for an admin UI,
  editing workflow, or multi-record management. Content changes are infrequent and can be made by
  editing a config file and redeploying. Introducing ActiveRecord + migrations + seed data for a
  single static profile and a handful of products would add unjustified complexity.
- **Alternatives considered**: ActiveRecord models with a `bakery_profiles`/`products` table
  (rejected — no CRUD, no multiple bakeries, no admin requirement in spec); hardcoding content
  directly in the ERB view (rejected — mixes content with markup, harder to maintain than a
  single YAML file).

## Decision: WhatsApp contact number configuration
- **Decision**: Read the number from `ENV["WHATSAPP_CONTACT_NUMBER"]` (already stored in the
  project's `.env` file for local development) via `Rails.application.credentials` fallback not
  required since this is not a secret credential, just a business contact number kept out of
  source-controlled code for easy updates.
- **Rationale**: Matches the spec's FR-003 requirement (configuration value, not hardcoded) and
  the constitution's Security & Data Privacy principle (use ENV/credentials for configurable
  values). `dotenv-rails` (or Rails' built-in credentials, but ENV is simpler here) loads `.env`
  in development.
- **Alternatives considered**: Rails encrypted credentials (rejected for this value — it's not a
  secret, ENV is simpler and matches the user's explicit request to use a `.env` file).

## Decision: WhatsApp link format
- **Decision**: Use a `https://wa.me/<number>?text=<url-encoded greeting>` link, with `<number>`
  in E.164-like digits-only format derived from the configured contact number.
- **Rationale**: `wa.me` links work uniformly across mobile (opens WhatsApp app) and desktop
  (opens WhatsApp Web or prompts for the desktop app) without needing separate mobile/desktop
  detection logic, satisfying FR-004.
- **Alternatives considered**: `whatsapp://send?phone=...` (rejected — mobile-app-only scheme,
  fails on desktop browsers).

## Decision: Testing approach
- **Decision**: RSpec request specs covering the root page (Spanish content present, WhatsApp
  link href correct with pre-filled message, address/hours/product sections present, social
  media "coming soon" section present) plus a view/helper unit spec for WhatsApp URL generation.
- **Rationale**: Constitution Principle I (Test-First) mandates tests before implementation.
  Request specs are the Rails-idiomatic way to verify rendered page content and links without
  the overhead of full browser/system specs, appropriate for a static content page.
- **Alternatives considered**: System specs with Capybara + headless browser (deferred — useful
  later for responsive/JS checks, but adds setup overhead not justified for a static page with no
  JS-dependent behavior).

## Decision: Frontend styling
- **Decision**: Plain CSS (asset pipeline default, e.g., `app/assets/stylesheets/bakery.css`) for
  the warm bakery color palette (cream/beige background, brown text/accents, terracotta/mustard
  accent), no CSS framework.
- **Rationale**: Simplicity & YAGNI — a single landing page does not need a full CSS framework;
  plain CSS keeps the dependency footprint minimal and matches "simple colors" from the spec.
- **Alternatives considered**: Tailwind CSS or Bootstrap (rejected for this feature — adds a
  build step / dependency not justified by a single static page; can be reconsidered if the site
  grows more pages).

**Output**: All "NEEDS CLARIFICATION" items from Technical Context are resolved above.
