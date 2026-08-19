# Client Documentation Reference

Guidance for the `client` audience. Read alongside `SKILL.md` Step 4 (Design Documentation).

Client documentation explains the solution to the people who commissioned it, fund it, or are accountable for it operationally — not to its engineers or its end users. It answers "what did we get, what does it do, what does it mean for the business" — implementation detail appears only when it drives a business or operational decision.

---

## Possible sections

Generate only what applies to the delivered solution and the requested scope.

| Section | Include when |
|---------|--------------|
| Solution overview | Whole-solution scope; the reader needs the big picture first |
| Purpose | The "why this was built" isn't self-evident from the feature list |
| Business context | The solution exists to solve a specific business problem worth restating |
| Capabilities | There's a concrete set of things the solution enables the business to do |
| Major features | The solution has distinct, nameable features worth listing individually |
| Business rules | The system encodes rules with business consequences (pricing, eligibility, limits, approvals) |
| User roles | The solution has distinct roles with different permissions or responsibilities |
| Workflows | There are end-to-end business processes the solution supports |
| Integrations | The solution connects to other systems the business relies on |
| Data handled | The solution processes data the business is accountable for (PII, financial, regulated) |
| Operational model | Someone on the business side needs to know how the solution runs day to day |
| Dependencies | The solution relies on external services, providers, or teams the business should be aware of |
| Security and access model | At a level appropriate for a non-technical stakeholder — who can access what, and why that matters |
| Limitations | The solution intentionally doesn't cover something a stakeholder might assume it does |
| Assumptions | A decision was made under an assumption that, if wrong, changes the outcome |
| Responsibilities | It's not obvious who owns what after delivery (support, maintenance, data) |
| Relevant technical constraints | A technical fact directly shapes a business decision (e.g., "reports refresh nightly, not real-time") |
| Release or delivery information | The reader needs to know what was delivered, when, and what's still pending |

## Tone and depth

Write for someone who makes decisions about the business, not the code. Every sentence should answer "so what does this mean for us" — a fact with no business or operational consequence doesn't belong here, no matter how true it is.

- State business rules as rules ("orders above $500 require manager approval"), not as the code path that enforces them
- State the security model as guarantees and boundaries ("only finance-role users can export payment data"), not as the mechanism ("JWT with role claims validated by middleware")
- When a technical constraint matters to the business, state the constraint and its consequence together — never the constraint alone, unexplained

## What never belongs in client documentation

- Class names, function names, file paths, database schema
- Implementation choices with no business consequence (a caching strategy, an internal library choice)
- Anything still in a plan, backlog, or holomap presented as if it were delivered

## Adaptation example: authentication

Client documentation for the same authentication system frames it as a business and operational concern:

- The authentication model in plain terms (e.g., "email and password, with optional single sign-on via [provider]")
- Roles and what each can do
- Access control guarantees relevant to compliance or contractual obligations
- Identity provider integrations, if any, and what depending on them means operationally
- Security and operational implications (e.g., "accounts lock after 5 failed attempts — support can unlock them")

It never explains token lifecycles or middleware — that's `developer-documentation.md`. Compare with `user-documentation.md` for the same system's task framing.
