# Tasks: About and Quality Sections

## Phase 1: Test-first

- [x] T001 [US1] Add request expectations for process title, introduction, four steps, closing statement, and `como-trabajamos` drawer anchor in `spec/requests/bakery_page_spec.rb`
- [x] T002 [US2] Add request expectations for quality title, introduction, four cards, closing statement, and `calidad-y-cuidado` drawer anchor in `spec/requests/bakery_page_spec.rb`
- [x] T003 Run `bundle exec rspec spec/requests/bakery_page_spec.rb` and confirm the new expectations fail for missing sections

## Phase 2: Implementation

- [x] T004 [US1] Add semantic process timeline markup and exact Spanish copy in `app/views/bakery/home.html.erb`
- [x] T005 [US2] Add semantic quality card grid markup and exact Spanish copy in `app/views/bakery/home.html.erb`
- [x] T006 [US1] [US2] Add drawer links for both anchors in `app/views/bakery/home.html.erb`
- [x] T007 [US1] Add responsive workflow timeline styles and reduced-motion handling in `app/assets/stylesheets/bakery.css`
- [x] T008 [US2] Add responsive quality grid, card hover, icon marks, and reduced-motion handling in `app/assets/stylesheets/bakery.css`

## Phase 3: Validation

- [x] T009 Run `bundle exec rspec` and `node --check app/assets/javascripts/bakery.js`
- [x] T010 Check the landing page at 1440px, 1024px, 768px, 430px, and 375px for overflow and clipping

## Dependencies

T001 and T002 precede T003. T003 precedes T004-T008. T004-T008 precede T009-T010.

## MVP

The MVP is T001-T009: both sections, drawer anchors, responsive styles, and automated validation.
