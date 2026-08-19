# Documentation Review Checklist

Used in `SKILL.md` Step 7 (Editorial Review) and in Review Mode. Run every applicable category against the target document(s). Record findings with the severity scale below — don't just note "something's off," name which category it falls under.

---

## Severity scale

| Severity | Definition |
|----------|------------|
| **Critical** | Technically incorrect information capable of misleading the reader — a wrong parameter, a stale claim about behavior, a broken procedure |
| **Major** | Missing, ambiguous, or structurally inadequate information that compromises the document's usability — a procedure with no expected result, an undocumented prerequisite, a section that should exist but doesn't |
| **Minor** | Clarity, consistency, or terminology issues — inconsistent naming, a passive-voice sentence in a procedure, a heading that doesn't describe its section |
| **Suggestion** | Optional editorial improvement — a reorganization that would help but isn't broken as-is |

---

## Categories

**Correctness** — Does every technical claim match the current implementation (Step 6 of `SKILL.md`)? Are examples runnable and accurate? Are status codes, parameter names, and configuration keys exactly right?

**Completeness** — Are prerequisites stated? Is the expected outcome stated? Are error cases covered where they matter? Is anything referenced but never explained?

**Clarity** — Second person and active voice in procedures? One idea per paragraph? Any sentence that requires a second read to parse?

**Concision** — Any filler ("please note that," "it is important to," "simply")? Any sentence that says in twenty words what ten would cover?

**Consistency** — Same term for the same concept throughout? Same formatting convention for code/UI/paths throughout? Same heading style and depth throughout the document set?

**Structure** — Do headings describe their section specifically enough to scan by? Are lists used where they aid comprehension and prose used where they don't? Is content in the section a reader would expect, given the heading?

**Audience fit** — Does a developer document leak into user-only concerns, or a client document into implementation detail with no business consequence? Would this audience's reader actually need every section present?

**Terminology** — Are acronyms expanded on first use where the audience needs it? Is jargon appropriate to this specific audience (see the audience reference files)?

**Language and locale** — Is the document in the language determined by `SKILL.md` Step 1, consistently, start to finish? For Portuguese, is the locale (pt-BR vs. pt-PT) consistent, and free of mechanically imported English grammar or punctuation? Does prescriptive language match its actual force — no "deveria" standing in for a mandatory or a recommended action (see `google-style.md`)? Are UI labels, code identifiers, API names, and quoted interface text left in their original form?

**Accessibility** — Alt text on images that convey information? No direction-dependent instructions? No idiom or metaphor that fails for a non-native or international reader?

**Duplication** — Is the same explanation repeated verbatim across documents instead of linked? Is content duplicated across audiences without being reshaped for each (see `SKILL.md` Step 4)?

**Broken references** — Do relative links resolve to files that exist? Do referenced sections, anchors, and filenames match what's actually on disk? Does anything link to a document that was renamed or removed?

---

## Procedure

1. Read the target document(s) in full before flagging anything — a fragment read out of context produces false positives.
2. Run every category above; skip a category only if it's genuinely inapplicable (e.g., Accessibility has nothing to check in a document with no images).
3. Record each finding with: location (heading or line), category, severity, and what's wrong.
4. In **Review Mode**, stop here and present findings — do not edit unless the user asks for fixes.
5. When fixing (Step 7 of the generation workflow, or Review Mode after a fix request), apply changes, then re-run Correctness and Broken References on the changed sections before closing out.
