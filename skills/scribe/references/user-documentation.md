# User Documentation Reference

Guidance for the `user` audience. Read alongside `SKILL.md` Step 4 (Design Documentation).

User documentation is task-oriented: it exists to get someone from "I want to do X" to "I did X" with the fewest surprises. It never leaks implementation details the task doesn't require — a user doesn't need to know how the token refresh works to understand what a session timeout looks like on screen.

---

## Possible sections

Generate only what the product actually has and what the requested scope needs.

| Section | Include when |
|---------|--------------|
| Introduction | Whole-product scope; the reader needs to know what this thing is before using it |
| Getting started | There's an onboarding path a new user follows |
| Account setup | Signup, account creation, or initial configuration exists |
| Onboarding | The product has a guided first-use flow worth documenting |
| Concepts the user needs | A term or model (e.g., "workspace," "project," "role") isn't self-explanatory and appears throughout the UI |
| Common workflows | There are repeatable multi-step tasks users perform |
| Step-by-step procedures | A specific feature has enough steps or non-obvious behavior to warrant its own walkthrough |
| Feature guides | A feature is substantial enough to deserve its own document rather than a paragraph |
| Examples | A concrete example clarifies a workflow better than prose alone |
| Expected outcomes | It's not obvious from the UI what "success" looks like after an action |
| Warnings and prerequisites | An action has a precondition or an irreversible consequence the user must know before acting |
| Troubleshooting | Common failure points recur (validation errors, permission issues, expected-but-confusing states) |
| FAQ | Real, recurring questions exist — not manufactured ones |
| Known limitations | The product intentionally doesn't do something a user might expect it to |

## Structure for a task procedure

1. One-line statement of what the reader will accomplish
2. Prerequisites, if any (permissions, prior setup, required data)
3. Numbered steps — each one action, each in second person, active voice ("select," "enter," "confirm")
4. Expected result — what the reader sees when it worked
5. What to do if it doesn't work (link to troubleshooting, or inline note)

## What never belongs in user documentation

- Internal architecture, service names, database fields, or class/function names
- Implementation rationale ("we use a queue internally so...") unless it directly changes what the user should expect (e.g., "processing can take a few minutes")
- API contracts, unless the product's actual purpose is exposing an API to non-developer users (rare — usually that belongs in developer docs)
- Anything that exists only in a plan or roadmap and isn't shipped yet

## Adaptation example: authentication

User documentation for the same authentication system covers only what a user does and experiences:

- How to sign in
- How to reset a forgotten password
- What happens when a session expires, and what to do about it
- Common login problems and their fixes (wrong credentials, locked account, unverified email)

It never mentions token lifecycles, middleware, or endpoint contracts — those live in `developer-documentation.md`. Compare with `client-documentation.md` for the same system's business framing.
