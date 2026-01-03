# Global Python Conventions

## Tooling
- Always use `uv` for package management and running Python (e.g., `uv run pytest`, `uv add <dep>`)
- Never use pip, poetry, or conda directly
- Use `ty` for type checking, not mypy

## Code Style
- All code must be fully typed—no untyped functions, no `Any` unless unavoidable
- Prefer modular design: small functions, single responsibility, extract utilities early
- Docstrings should be minimal—state what isn't obvious from the signature, skip the rest

## Testing
- Use pytest for all tests
- Prefer fixtures over mocks—set up real objects/state rather than mocking behavior
- Every feature or fix requires corresponding tests
- A task is not complete until tests pass (`uv run pytest`)
- Run tests after making changes; if they fail, fix before reporting completion

## Guardrails
- Don't count work as done if tests are failing or type checking fails
- Run `ty check` before considering typed code complete

# Swift and SwiftUI conventions
## Code Style
- Use SwiftUI for UI; avoid UIKit unless necessary
- Prefer value types (structs) over classes where possible
- Extract reusable views into separate files early

## Structure
- Keep views small—if a view body exceeds ~100 lines, extract subviews
- Separate business logic from views (ViewModels or similar)

## Testing
- Write tests for logic/ViewModels; don't stress about testing views directly
- Use XCTest
- Whenever you're finished making changes always try to build the project before returning to me. If the build errors, fix it.

# Git
- Don't commit unless explicitly asked
- When committing, use conventional commit format

# Autonomy
- Don't ask before running tests or type checks
- Ask before deleting files or modifying config
