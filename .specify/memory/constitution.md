<!--
Sync Impact Report
- Version change: TEMPLATE → 1.0.0
- Modified principles: initial ratification (all 6 principles newly defined)
- Added sections: Core Principles (I-VI), Technology Constraints, Development Workflow, Governance
- Removed sections: none
- Follow-up TODOs: none
-->
# Dulceria Web Ruby Constitution

## Core Principles

### I. Test-First (NON-NEGOTIABLE)
Tests MUST be written before implementation code. For every feature or bug fix: write a
failing test (unit, request, or system spec) → confirm it fails for the right reason → implement
the minimal code to pass → refactor. Red-Green-Refactor is strictly enforced; no PR merges with
untested behavior. Rationale: catalog, cart, and checkout logic handle money and inventory, where
regressions directly cost the business revenue and customer trust.

### II. Simplicity & YAGNI
Prefer the simplest solution that satisfies current, real requirements. Do not add abstractions,
configuration options, gems, or services for hypothetical future needs. Every added layer
(service object, module, background job) MUST be justified by an existing requirement, not a
speculative one. Rationale: a small storefront team cannot afford to maintain unnecessary
complexity; simple Rails idioms are easier to onboard, debug, and extend.

### III. Mandatory Code Review
No change reaches `main` without at least one review approval verifying: constitution
compliance, test coverage for the change, and adherence to Rails conventions (Principle IV).
Reviewers MUST block merges that skip tests, bypass validations, or introduce complexity without
justification. Rationale: a second set of eyes is the cheapest defense against defects in a
customer-facing e-commerce app.

### IV. Rails Conventions & MVC Discipline
Follow Ruby on Rails and MVC conventions by default: fat models/skinny controllers only where
domain logic naturally belongs, no business logic in views, RESTful routes and controllers unless
a documented exception exists. Use standard Rails generators, naming, and directory structure
before introducing custom patterns. Rationale: convention over configuration keeps the codebase
predictable and lowers the cost of adding contributors.

### V. Security & Data Privacy
Any code touching customer PII, authentication, or payment data MUST: use parameterized
queries/ActiveRecord (never raw SQL interpolation), enforce strong params, never log secrets or
full payment details, and use HTTPS and encrypted credentials (Rails credentials/ENV) for all
secrets. Payment processing MUST delegate to a PCI-compliant provider; raw card data MUST NOT be
persisted. Rationale: this is a commercial site handling customer and payment data; security
lapses carry legal and financial risk.

### VI. Observability & Logging
Application errors and key business events (orders placed, payments failed, inventory changes)
MUST be logged with enough context (request id, user/order id, timestamp) to diagnose issues
without reproducing them locally. Use structured logging and an error-tracking integration in
production. Rationale: a small team needs production visibility to resolve customer-impacting
issues quickly without guesswork.

## Technology Constraints

The project is built on Ruby on Rails. Database access MUST go through ActiveRecord unless a
documented performance exception exists. Background/async work MUST use the project's configured
job framework (e.g., Active Job) rather than ad hoc threads. Frontend changes MUST work with the
project's existing asset/view pipeline; introducing a new frontend framework requires explicit
justification and review.

## Development Workflow

All work follows: spec → plan → tasks → implementation, using the Spec Kit commands. Every
feature branch MUST pass its test suite locally before opening a PR. PRs MUST include a
description of what changed and why, and MUST NOT be merged without the review required by
Principle III. Direct pushes to `main` are not permitted.

## Governance

This constitution supersedes any conflicting team practice or ad hoc convention. Amendments
require: a documented rationale, update of this file, and a version bump per semantic versioning
(MAJOR for incompatible principle removals/redefinitions, MINOR for new principles/sections,
PATCH for clarifications/wording). All PRs and reviews MUST verify compliance with these
principles; unjustified complexity MUST be flagged and resolved before merge.

**Version**: 1.0.0 | **Ratified**: 2026-08-21 | **Last Amended**: 2026-08-21
