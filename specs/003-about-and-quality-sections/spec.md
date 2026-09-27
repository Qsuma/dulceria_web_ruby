# Feature Specification: About and Quality Sections

**Feature Branch**: `003-about-and-quality-sections`
**Created**: 2026-09-27
**Status**: Ready for implementation
**Input**: Add institutional process and quality content to the existing Dulces Lore single-page landing page.

## User Scenarios & Testing

### User Story 1 - Understand How Dulces Lore Works (Priority: P1)

A visitor wants to understand how ordering works before choosing a pack or creating a custom offer.

**Independent Test**: Open `/` and verify the process section, all four steps, closing statement, anchor, and drawer link are present in Spanish.

**Acceptance Scenarios**:
1. Given a visitor is viewing the landing page, when they reach `#como-trabajamos`, then they see the title "Todo empieza con una idea dulce.", the introduction, four ordered steps, and the closing statement.
2. Given a visitor uses the drawer, when they select "Cómo trabajamos", then the page scrolls to the process section.
3. Given a visitor uses a mobile viewport, when they view the process, then the four steps form a readable vertical timeline without horizontal overflow.

### User Story 2 - Trust the Bakery's Quality and Care (Priority: P1)

A visitor wants confidence that preparation, presentation, personalization, and communication receive deliberate attention.

**Independent Test**: Open `/` and verify the quality section, four cards, closing statement, anchor, and drawer link are present in Spanish.

**Acceptance Scenarios**:
1. Given a visitor is viewing the landing page, when they reach `#calidad-y-cuidado`, then they see the title "Hecho con cuidado. Pensado para compartir.", its introduction, four quality cards, and the closing statement.
2. Given a visitor uses a desktop viewport, when they view the quality section, then the cards form a two-column grid without clipping.
3. Given a visitor uses a mobile viewport, when they view the quality section, then the cards form one readable column without horizontal overflow.

## Requirements

- **FR-001**: The landing page MUST include a semantic section with id `como-trabajamos` and the exact process title and provided Spanish copy.
- **FR-002**: The process section MUST render four ordered steps: Elige, Personaliza, Confirmamos, and Preparamos, each with its provided description.
- **FR-003**: The process section MUST end with "Tú imaginas el momento. Nosotros ponemos el dulce.".
- **FR-004**: The landing page MUST include a semantic section with id `calidad-y-cuidado` and the exact quality title and provided Spanish copy.
- **FR-005**: The quality section MUST render four cards titled Ingredientes y elaboración, Presentación, Pedidos personalizados, and Atención cercana, each with its provided description.
- **FR-006**: The quality section MUST end with "Pequeños detalles hacen grandes momentos.".
- **FR-007**: The drawer MUST include working anchors for both new sections without removing its existing destinations.
- **FR-008**: New sections MUST reuse the existing Dulces Lore variables, typography, responsive conventions, and reduced-motion behavior.
- **FR-009**: The feature MUST remain a single Rails/ERB landing page and MUST NOT add frontend frameworks, database models, or routes.
- **FR-010**: At viewports 1440px, 1024px, 768px, 430px, and 375px, the new sections MUST avoid horizontal overflow, clipped text, and overlapping cards.

## Success Criteria

- **SC-001**: All required institutional headings, steps, cards, anchors, and closing statements are present in the rendered page.
- **SC-002**: A visitor can reach both new sections from the drawer in one click.
- **SC-003**: The process and quality sections remain readable with no horizontal scroll at all five target viewport widths.
- **SC-004**: The visual language remains consistent with the existing cream, pink, coral, chocolate, lilac, and mint palette.

## Assumptions

- Institutional copy is stable content and remains directly in the ERB view, consistent with the current static landing-page architecture.
- CSS characters and pseudo-elements are sufficient for the requested visual marks; no icon dependency is needed.
- Existing smooth scrolling and drawer JavaScript are sufficient; no new JavaScript behavior is required.
