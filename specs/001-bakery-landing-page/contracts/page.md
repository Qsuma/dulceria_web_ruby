# Contract: Bakery Landing Page Route

## GET /

**Description**: Renders the bakery landing page (single page, no query params required).

**Response**: `200 OK`, `Content-Type: text/html`

**Response body MUST include**:
- Bakery name ("Dulces Lore") and tagline, in Spanish
- At least one product highlight (name + description)
- Address and business hours
- A "social media coming soon" section (no live social links)
- A WhatsApp contact link/button with:
  - `href` matching `https://wa.me/<digits-only-number>?text=<url-encoded greeting>`
  - Visible label in Spanish (e.g., "Contactar por WhatsApp")

**Failure modes**:
- If `WHATSAPP_CONTACT_NUMBER` is not configured, the request MUST fail fast with a clear
  configuration error (not a silently broken link), surfaced during boot or first request in
  development; this is an internal safeguard, not a user-facing error page requirement.

**No other routes/endpoints** are introduced by this feature — it is a single self-contained
landing page (FR-007).
