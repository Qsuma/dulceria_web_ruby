# Tasks: Bakery Landing Page

**Input**: Design documents from `specs/001-bakery-landing-page/`
**Prerequisites**: [plan.md](./plan.md), [spec.md](./spec.md), [research.md](./research.md), [data-model.md](./data-model.md), [contracts/page.md](./contracts/page.md), [quickstart.md](./quickstart.md)

**Tests**: Included — the project constitution (Principle I, Test-First) mandates tests written
before implementation for every feature.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependency on incomplete tasks)
- **[Story]**: Which user story this task belongs to (US1, US2)
- File paths are relative to the repository root

## Path Conventions

Single Rails application at the repository root (per [plan.md](./plan.md) Project Structure):
`app/`, `config/`, `spec/` at the repo root.

---

## Phase 1: Setup (Project Initialization)

- [X] T001 Generate a new minimal Rails 7.1 app at the repository root (`rails new . --minimal --skip-test`), preserving the existing `.env`, `.gitignore`, `.github/`, and `.specify/` files
- [X] T002 Add `rspec-rails` and `dotenv-rails` to the `Gemfile`, run `bundle install`
- [X] T003 [P] Run `bin/rails generate rspec:install` to scaffold `spec/spec_helper.rb` and `spec/rails_helper.rb`
- [X] T004 [P] Require `dotenv/rails-now` (or equivalent) so `config/application.rb` loads `.env` in development

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure required before any user story can be implemented or tested.

- [X] T005 Add `root "bakery#home"` to `config/routes.rb`
- [X] T006 Create `app/controllers/bakery_controller.rb` with a `#home` action rendering `bakery/home`
- [X] T007 Create `config/bakery.yml` with `name: "Dulces Lore"`, `tagline`, `address`, `business_hours`, and a `products` list (name/description/image_path) per [data-model.md](./data-model.md)
- [X] T008 Create `app/models/bakery_profile.rb` (plain Ruby object, not ActiveRecord) that loads `config/bakery.yml` and exposes `name`, `tagline`, `address`, `business_hours`, `products`, raising a clear configuration error if `ENV["WHATSAPP_CONTACT_NUMBER"]` is missing
- [X] T009 Create `app/helpers/bakery_helper.rb` with a `whatsapp_link` method building a `https://wa.me/<digits>?text=<url-encoded greeting>` URL from `ENV["WHATSAPP_CONTACT_NUMBER"]` and the fixed greeting "Hola, quisiera más información sobre sus productos."

**Checkpoint**: Foundation ready — user story implementation can now begin.

---

## Phase 3: User Story 1 - Discover the Bakery and Its Offerings (Priority: P1)

**Goal**: A visitor sees the bakery name, tagline, products, address/hours, and a social-media
"coming soon" note, all in Spanish, in a professional warm-toned layout.

**Independent Test**: Load `GET /` and verify the name, tagline, products, address, hours, and
social-media-coming-soon section render in Spanish with no broken/cluttered layout.

- [ ] T010 [P] [US1] Write request spec in `spec/requests/bakery_page_spec.rb` asserting `GET /` returns 200 and the response body includes the bakery name, tagline, at least one product name/description, address, business hours, and a social-media "coming soon" phrase, all in Spanish
- [ ] T011 [US1] Create `app/views/bakery/home.html.erb` with sections for name/tagline, product highlights, address/hours, and social-media-coming-soon, using `BakeryProfile` (T008)
- [ ] T012 [US1] Create `app/assets/stylesheets/bakery.css` with the warm bakery palette (cream/beige background, brown text/accents, terracotta/mustard accent), clean typography, and a responsive layout (no horizontal scroll on mobile widths)
- [ ] T013 [P] [US1] Add product images under `app/assets/images/` (or placeholders) and reference them in `app/views/bakery/home.html.erb`, ensuring the layout degrades gracefully when `image_path` is absent

**Checkpoint**: User Story 1 is independently testable and deliverable.

---

## Phase 4: User Story 2 - Contact the Bakery via WhatsApp (Priority: P1)

**Goal**: A visitor can find and activate a WhatsApp contact link/button from anywhere on the
page, opening a chat pre-filled with a greeting, on both mobile and desktop.

**Independent Test**: Click/tap the WhatsApp link on `GET /` and verify its `href` matches the
`wa.me` contract with the correct number and pre-filled greeting.

- [ ] T014 [P] [US2] Write request spec in `spec/requests/bakery_page_spec.rb` asserting the WhatsApp link's `href` matches `https://wa.me/<digits>?text=...` with the configured number and the greeting "Hola, quisiera más información sobre sus productos." per [contracts/page.md](./contracts/page.md)
- [ ] T015 [P] [US2] Write helper spec in `spec/helpers/bakery_helper_spec.rb` for `BakeryHelper#whatsapp_link`, covering correct URL encoding and digits-only number formatting
- [ ] T016 [US2] Add a visibly prominent WhatsApp button/link (label "Contactar por WhatsApp") in `app/views/bakery/home.html.erb` using `whatsapp_link` (T009)
- [ ] T017 [US2] Update `app/assets/stylesheets/bakery.css` so the WhatsApp button remains visible while scrolling (e.g., sticky header or floating button)

**Checkpoint**: User Story 2 is independently testable and deliverable; both P1 stories together form the MVP.

---

## Phase 5: Polish & Cross-Cutting Concerns

- [ ] T018 [P] Write request spec in `spec/requests/bakery_page_spec.rb` (or a config/initializer spec) asserting the app fails fast with a clear error when `WHATSAPP_CONTACT_NUMBER` is unset, per the Edge Cases and [data-model.md](./data-model.md) validation rules
- [ ] T019 [P] Manually run through [quickstart.md](./quickstart.md) validation steps on a mobile viewport (≈375px) and a desktop viewport (≈1440px), fixing any layout issues found
- [ ] T020 Update `README.md` with setup instructions, including the `WHATSAPP_CONTACT_NUMBER` environment variable requirement

---

## Dependencies & Execution Order

- **Phase 1 (Setup)**: No dependencies — start here.
- **Phase 2 (Foundational)**: Depends on Phase 1. Blocks all user stories.
- **Phase 3 (US1)**: Depends on Phase 2. Independent of US2.
- **Phase 4 (US2)**: Depends on Phase 2. Independent of US1 (can run in parallel with Phase 3 by a different contributor, though both share `home.html.erb`/`bakery.css` so coordinate edits).
- **Phase 5 (Polish)**: Depends on Phase 3 and Phase 4 being complete.

## Parallel Execution Examples

- Within Phase 1: T003 and T004 can run in parallel after T002.
- Within Phase 3: T010 and T013 can run in parallel (different files); T011 and T012 depend on T008/T010 conceptually but touch different files from T013.
- Within Phase 4: T014 and T015 can run in parallel (different spec files).
- Within Phase 5: T018 and T019 can run in parallel.

## Implementation Strategy

**MVP Scope**: Complete Phase 1 → Phase 2 → Phase 3 (US1) → Phase 4 (US2). These four phases
deliver the full spec (both P1 stories) since there are no lower-priority stories in this feature.
Phase 5 (Polish) hardens edge cases and validates responsiveness before calling the feature done.
