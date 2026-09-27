# Implementation Plan: About and Quality Sections

**Branch**: `dev`  **Date**: 2026-09-27  **Spec**: [spec.md](./spec.md)

## Summary

Add two institutional sections to the existing ERB landing page: a responsive four-step process timeline and a four-card quality/care grid. Extend the existing drawer with two anchor links and reuse the established CSS variables, typography, reduced-motion handling, and page rhythm.

## Technical Context

- **Language**: Ruby/Rails server-rendered ERB
- **Frontend**: Existing vanilla CSS and JavaScript asset pipeline; no new dependencies
- **Data**: No new data model, YAML keys, database tables, routes, or controller changes
- **Testing**: Request specs in `spec/requests/bakery_page_spec.rb`
- **Responsive targets**: 1440px, 1024px, 768px, 430px, 375px

## Constitution Check

- **Test-first**: PASS. New request expectations will be added and confirmed failing before view/CSS implementation.
- **Simplicity/YAGNI**: PASS. Static institutional copy stays in the existing view; no new abstraction or dependency.
- **Rails/MVC**: PASS. No controller or model change; semantic content remains in the single view.
- **Security/privacy**: PASS. No user data, authentication, payment, or secrets involved.
- **Technology constraints**: PASS. Existing Rails/ERB/CSS/vanilla JavaScript pipeline only.

## Implementation Steps

1. Add request expectations for both section titles, exact copy, step/card headings, closing phrases, and drawer anchors.
2. Run the focused request spec and confirm the new expectations fail because the sections are absent.
3. Add the process and quality semantic sections between the custom-offer and visit sections in `home.html.erb`.
4. Add the two drawer links in `home.html.erb` while preserving all existing links.
5. Add scoped `.workflow-*` and `.quality-*` styles to `bakery.css`, including desktop/mobile layouts, CSS visual marks, hover states, and reduced-motion behavior.
6. Run request specs, JavaScript syntax validation, and responsive/browser checks at the five target widths.

## Files

- `app/views/bakery/home.html.erb`
- `app/assets/stylesheets/bakery.css`
- `spec/requests/bakery_page_spec.rb`

No changes planned for `BakeryController`, `BakeryProfile`, `config/bakery.yml`, `bakery.js`, or routes.
