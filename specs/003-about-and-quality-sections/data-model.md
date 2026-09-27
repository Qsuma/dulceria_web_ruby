# Data Model: About and Quality Sections

No new data model is introduced.

The two sections contain stable institutional copy and visual metadata represented directly in the ERB view. They do not require persistence, validation, ActiveRecord entities, controller data loading, or YAML configuration.

Existing entities remain unchanged:

- `BakeryProfile` continues to provide bakery, pack, product, and contact data.
- Existing pack and custom-offer behavior remains outside this feature's scope.
