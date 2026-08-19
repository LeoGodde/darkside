# Developer Documentation Reference

Guidance for the `developer` audience. Read alongside `SKILL.md` Step 4 (Design Documentation).

Developer documentation explains the system to someone who will read, run, extend, or operate its code. It can go as deep as the implementation requires — this audience is the one exception to hiding internal detail, but depth still has to earn its place: document what a developer needs to work in this codebase, not everything that happens to be true about it.

---

## Possible sections

Generate only what the project actually has and what the requested scope needs. This is a menu, not a checklist to fill mechanically.

| Section | Include when |
|---------|--------------|
| Project overview | Whole-project scope; a new developer needs orientation before anything else |
| Architecture | The system has enough structure that "where does X live" isn't obvious from the folder tree alone |
| Getting started / local setup | The project can be run locally and a developer would need to |
| Project structure | The folder layout encodes meaningful conventions worth explaining |
| Modules and components | The codebase has clear internal boundaries worth naming and explaining individually |
| APIs | The project exposes an API — internal or external |
| Authentication and authorization | The system has an auth model a developer needs to work with or extend |
| Data model | There's a schema, and understanding it materially helps development |
| Configuration | There are settings a developer needs to know about beyond defaults |
| Environment variables | The project reads env vars — document each one actually read in code |
| Integrations | The system talks to external services worth documenting individually |
| Background jobs | The system has scheduled or queued work |
| Events and messaging | The system publishes or consumes events |
| Testing | There's a test suite — how to run it, what's covered, conventions to follow |
| Deployment | There's a deploy process a developer would need to trigger or understand |
| Observability | Logging, metrics, or tracing exist and following them requires explanation |
| Security considerations | There are non-obvious security constraints a developer must respect |
| Development workflows | Branching, PR, or release conventions exist and aren't obvious from tooling alone |
| Troubleshooting | Known failure modes recur often enough to be worth documenting |
| Extension points | The system was designed to be extended in specific, documented ways |
| Technical limitations | Known constraints a developer would otherwise discover the hard way |
| Architectural decisions | A non-obvious decision has a rationale worth preserving (often sourced from a war-room plan or imperial order, confirmed against the resulting code) |

## Structure for an API reference entry

For each endpoint or public interface, cover only what applies:

- Purpose (one line)
- Method / signature
- Parameters — name, type, required/optional, constraint
- Request example (realistic, runnable)
- Response — shape, status codes, error cases
- Auth requirement

Verify every field, type, and status code against the actual implementation (Step 6 of `SKILL.md`) — an API reference with an invented parameter is worse than no reference at all.

## Structure for a getting-started guide

1. Prerequisites (tools, versions, accounts)
2. Setup steps, numbered, each with the expected result
3. How to verify the setup worked (a command to run, an output to expect)
4. Where to go next (link to architecture or the first task-relevant doc)

## Adaptation example: authentication

Developer documentation for an authentication system explains the mechanism:

- The authentication flow, step by step (request → token issuance → validation)
- Token lifecycle: issuance, expiry, refresh, revocation
- Middleware or interceptors involved and where they sit in the request pipeline
- Relevant endpoints and their contracts
- Configuration (secrets, expiry windows, providers)
- Error states a client of the API needs to handle

Contrast with `user-documentation.md` (how to log in) and `client-documentation.md` (the authentication model as a business/operational concern) — same system, three different documents, none of them a resized copy of another.
