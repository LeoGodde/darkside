# Shared Rules

Rules referenced by all Darkside skills. When a skill says "Follow Shared Rules", apply everything below.

---

## Communication

- All messages to the user are in Brazilian Portuguese
- All generated files are written in English

## Interaction

- One question or block at a time — never ask two questions in the same message
- Wait for the user's answer before continuing
- One follow-up allowed if the answer is ambiguous — do not interrogate
- Never propose code during discovery conversations (quest, war-room, interrogate)

## Files

- If the user stops mid-session, preserve the partial file with its "in progress" header — do not delete it
- Always write each section to the file before moving to the next
- Communication is simple, direct, and easy to understand — no unnecessary jargon, without compromising technical precision

## Filename Derivation

When a skill says "derive filename", apply these steps:

1. Lowercase
2. Remove accents (`ã` → `a`, `ç` → `c`)
3. Spaces → `-`
4. Remove non-alphanumeric except `-`
5. Collapse consecutive `-`
6. Prepend `YYYY-MM-DD-`
7. Append the suffix specified by the skill (e.g., `-plan.md`, `-order.md`, `.md`)

## Prerequisite Check

When a skill says "check prerequisite [path]", do:

- If the file/directory does not exist: say the message specified by the skill and stop
- If it exists: read it in full and use as context throughout the session
