# Research: About and Quality Sections

## Decision: Keep institutional copy in the ERB view

**Rationale**: The current page is a single static landing page. `BakeryProfile` and `config/bakery.yml` own bakery and offer data, while these sections are fixed editorial content with no runtime configuration or business rules. Keeping the copy in `home.html.erb` avoids adding a new data abstraction for stable text.

**Alternatives considered**: Adding institutional keys to `config/bakery.yml` was rejected because it would mix presentation copy with the existing bakery/pack data and add indirection without a current requirement.

## Decision: Use semantic HTML and existing vanilla CSS

**Rationale**: The project already uses ERB, `bakery.css`, and vanilla `bakery.js`. The requested timeline and card grid can be implemented with CSS grid, flexbox, pseudo-elements, and existing reduced-motion rules.

**Alternatives considered**: A frontend framework or icon library was rejected by the feature constraints and would add unnecessary dependencies.

## Decision: Extend the existing drawer only with anchor links

**Rationale**: The existing drawer already closes links and supports smooth anchor navigation. Adding two links preserves the current navigation contract without changing JavaScript.

**Alternatives considered**: A new page or route was rejected because the feature must remain on the single landing page.
