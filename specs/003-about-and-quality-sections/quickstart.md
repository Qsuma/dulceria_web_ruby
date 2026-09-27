# Quickstart: About and Quality Sections

## Run

```bash
bin/dev
```

Visit `http://localhost:3000/`.

## Automated validation

```bash
bundle exec rspec spec/requests/bakery_page_spec.rb
node --check app/assets/javascripts/bakery.js
```

## Manual responsive checks

At 1440px, 1024px, 768px, 430px, and 375px:

1. Open the drawer and select "Cómo trabajamos"; confirm the page reaches `#como-trabajamos`.
2. Confirm the four process steps form a horizontal timeline on desktop and a vertical timeline on mobile.
3. Select "Calidad y cuidado" from the drawer; confirm the page reaches `#calidad-y-cuidado`.
4. Confirm quality cards form a 2x2 grid on desktop and one column on mobile.
5. Verify no horizontal scrollbar, clipped copy, or overlapping cards exists.
6. Confirm reduced motion via browser accessibility settings disables or minimizes new animation.
