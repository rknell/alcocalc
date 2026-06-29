# Alcocalc Agent Guidance

## Engineering Standard

- Build like the next request is the beginning of a larger feature set, not a one-off patch.
- Prefer small, named calculation APIs with focused tests over ad hoc formulas embedded at call sites.
- Keep domain logic pure and easy to verify with deterministic inputs and outputs.
- Preserve compatibility for existing consumers unless a migration is explicitly planned.
- Avoid coding the repo into a corner: document assumptions, units, precision behavior, and extension points for future distilling calculations.
- Treat units, rounding, precision, and edge cases as API behavior. Cover them with focused tests before exposing new calculation helpers to app repos.

## Common Commands

```powershell
dart pub get
dart analyze
dart test
```
