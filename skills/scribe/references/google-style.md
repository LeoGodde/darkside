# Google Developer Documentation Style — Practical Reference

Practical adaptation of the Google Developer Documentation Style Guide for Scribe's own use. This is a working summary, not a replacement — consult the source for anything not covered here. Attribution preserved: principles and terminology below are drawn directly from Google's guide.

## Primary source

Google Developer Documentation Style Guide

- Main guide: https://developers.google.com/style
- Highlights: https://developers.google.com/style/highlights
- Voice and tone: https://developers.google.com/style/tone
- Write for a global audience: https://developers.google.com/style/translation
- Write inclusive documentation: https://developers.google.com/style/inclusive-documentation
- Prescriptive documentation: https://developers.google.com/style/prescriptive-documentation
- Headings and titles: https://developers.google.com/style/headings
- Procedures: https://developers.google.com/style/procedures
- Lists: https://developers.google.com/style/lists
- Code in text: https://developers.google.com/style/code-in-text
- Cross-references and linking: https://developers.google.com/style/cross-references
- Capitalization: https://developers.google.com/style/capitalization
- Numbers: https://developers.google.com/style/numbers
- Jargon: https://developers.google.com/style/jargon
- Anthropomorphism: https://developers.google.com/style/anthropomorphism
- What's new: https://developers.google.com/style/whats-new

The Google Developer Documentation Style Guide states that its prose content is licensed under Creative Commons Attribution 4.0 unless otherwise noted. Code samples use the Apache 2.0 License. This skill does not bundle Google code samples — only paraphrased, adapted guidance drawn from the prose, cited back to the pages above.

Source reviewed for this version through the guide's July 7, 2026 change log.

## How to use this file

This file is depth, not a gate — `SKILL.md` already carries the principles Scribe needs to apply correctly on every run. Load this file when a document needs closer editorial attention, when reviewing existing docs, or when a rule's rationale matters for a judgment call. When a specific rule needs more nuance than covered here, go to the corresponding page above rather than guessing.

The **Language and Locale** section below is a Scribe-specific addition, not sourced from Google's guide — everything after it is the Google adaptation described above.

---

## Language and locale

Write in the language requested by the user. If none is specified, preserve the language of the source material or use the language of the user's request — see `SKILL.md` Step 1 for the exact priority order. This decision is independent of Darkside's Shared Rules, which mandate English for Scribe's own internal files (`.darkside/scribe/`) but say nothing about `docs/` — the human-facing documentation follows the language its actual audience needs.

Apply universal principles in every language: active voice, directness, consistency, accessibility, and precise terminology. Apply the language-specific rules below only to the language actually in use for a given document — never carry one language's grammar, punctuation, or idiom into another mechanically. A Portuguese document that reads like a literal translation of English sentence structure has failed this rule even if every word is correct.

### English

- Standard American spelling and punctuation (e.g., "color," not "colour"; "-ize," not "-ise").
- Sentence case for headings: "Configure the database connection," not "Configure The Database Connection."
- Serial comma in prose lists: "logs, metrics, and traces," not "logs, metrics and traces."

### Portuguese

Preserve the requested locale exactly — pt-BR or pt-PT — and never default one to the other or mix their conventions in the same document. Do not import English-only grammar or punctuation rules mechanically: for example, English's heavy use of the imperative in headings, its comma conventions, and its capitalization habits don't transfer to Portuguese by default — follow standard Portuguese usage for the chosen locale instead.

**Prescriptive writing in Portuguese** — the verb choice signals the actual force of the instruction, so pick it deliberately:

| Force | Use | Avoid |
|-------|-----|-------|
| Mandatory action | Imperative, or "é necessário" | "deveria" — reads as optional or ambiguous |
| Optional action / possible outcome (meaning already clear from context) | "pode" | Overqualifying an option as if it were a requirement |
| Recommendation | "recomendamos" or "é recomendável" | Stating a recommendation as a bare imperative, which reads as mandatory |

Examples:

| Avoid | Prefer | Why |
|-------|--------|-----|
| "O usuário deveria configurar a variável de ambiente." | "Configure a variável de ambiente." / "É necessário configurar a variável de ambiente." | The action is mandatory — "deveria" softens it into something that sounds skippable. |
| "Você deveria usar cache para melhorar a performance." | "Recomendamos usar cache para melhorar a performance." | It's a recommendation, not a requirement — say so directly instead of hedging with "deveria." |
| "É possível que o usuário deveria reiniciar o serviço." | "O serviço pode precisar ser reiniciado." | Stacking "é possível" and "deveria" buries a simple optional outcome in hedges. |

**Keep in the original form**, regardless of locale, unless the product ships an official localized label: UI element names, code identifiers (function, class, variable, file names), API names and parameters, and any quoted interface text. Translating `Save Changes` into "Salvar Alterações" in prose is wrong unless that's the actual, shipped label the reader will see on screen.

---

## Voice and tone

*Source: [Voice and tone](https://developers.google.com/style/tone)*

- Write like a knowledgeable friend, not a formal contract. Conversational but not chatty.
- Address the reader directly, in second person: "you," not "the user" or "one."
- Prefer active voice: "the server rejects the request," not "the request is rejected by the server." Passive voice is acceptable when the actor is unknown or irrelevant.
- State facts plainly. Avoid hype ("amazing," "powerful," "seamless") and avoid apologizing ("unfortunately," "simply," "just") — "simply" and "just" imply the task is trivial for a reader for whom it might not be.
- Don't anthropomorphize the system ("the server thinks," "the app wants," "the tool decided") — describe what it does, not what it intends. ([Anthropomorphism](https://developers.google.com/style/anthropomorphism))

## Clarity and concision

- One main idea per sentence, one topic per paragraph.
- Cut words that don't carry meaning: "in order to" → "to"; "please note that" → delete; "it is important to" → delete, state the fact.
- Prefer short sentences over long ones joined by conjunctions. Split compound instructions into steps.
- Define a term the first time it's used, then use it consistently — never alternate synonyms for the same concept across a document.

## Task orientation

*Source: [Procedures](https://developers.google.com/style/procedures)*

- Structure procedural content around what the reader is trying to accomplish, not around how the system is organized internally.
- State prerequisites before the first step, not embedded mid-procedure.
- State the expected result after a procedure — how the reader confirms it worked.
- Split a procedure into separate numbered steps whenever more than one distinct action is required; keep each step to one action.

## Structure and scanning

*Source: [Headings and titles](https://developers.google.com/style/headings), [Lists](https://developers.google.com/style/lists)*

- Descriptive headings: a reader scanning only headings should be able to reconstruct the document's shape. "Configure the database connection," not "Configuration."
- Use numbered lists only for sequences that must happen in order; use bulleted lists for unordered items; use a table when comparing several items across the same attributes.
- Lead each section with the most important sentence — don't bury the point in the third sentence.
- Keep paragraphs short. A wall of text defeats scanning even if every sentence is well written.

## Formatting code, commands, and UI elements

*Source: [Code in text](https://developers.google.com/style/code-in-text)*

- `Code font` for: code, commands, file names, paths, parameter names, values, environment variables, and any literal string the reader types or the system outputs.
- **Bold** for UI elements the reader interacts with directly: buttons, menu items, field labels.
- Never blend a code element into prose without formatting it — "run npm install" reads worse and is harder to scan than "run `npm install`."
- Show realistic, runnable examples. A placeholder like `<your-api-key>` is fine; an example that would fail if actually run is not.

## Capitalization and numbers

*Source: [Capitalization](https://developers.google.com/style/capitalization), [Numbers](https://developers.google.com/style/numbers)*

- Default to lowercase; capitalize only proper nouns, product/feature names that are officially capitalized, and the first word of a sentence or heading (sentence case — see Structure and scanning above).
- Don't capitalize a common noun just to make it look official ("the database," not "the Database," unless it's a proper product name).
- Spell out numbers zero through nine in prose; use numerals for 10 and above, and always for units, measurements, versions, and UI values ("3 retries," "version 2," "8 GB," not "eight GB").
- Use numerals in a sentence that mixes numbers above and below ten, for consistency ("the batch processes 4 of 12 items," not "four of 12 items").

## Links

*Source: [Cross-references and linking](https://developers.google.com/style/cross-references)*

- Link text describes the destination: "see the authentication guide," never "click here" or "see this page."
- Prefer linking the meaningful phrase over appending "(link)" after it.
- A relative link between two documents in the same `docs/` tree should still make sense if read out loud without the surrounding sentence.

## Precision: requirement vs. recommendation vs. option

*Source: [Prescriptive documentation](https://developers.google.com/style/prescriptive-documentation)*

- **must / required** — the reader has no choice; skipping it breaks the outcome
- **should / recommended** — the default path; deviating is possible but has a cost the reader should know about
- **can / optional** — a genuine choice with no default preference implied

Never write "should" when the actual constraint is "must," and never write "must" for something that's actually a recommendation — both misdirect the reader's risk assessment.

## Inclusive and accessible language

*Source: [Write inclusive documentation](https://developers.google.com/style/inclusive-documentation), [Write for a global audience](https://developers.google.com/style/translation)*

- Write for a global audience: avoid idioms, sports metaphors, cultural references, and humor that don't translate.
- Avoid ableist, gendered, or otherwise non-neutral language; there's almost always a neutral equivalent that loses nothing.
- Write alt text for images and diagrams that convey information — describe what the image communicates, not just what it depicts.
- Avoid direction-dependent instructions ("the button on the right") when a label-based reference works instead ("the **Save** button") — layouts shift, labels are stable.

## Acronyms and jargon

*Source: [Jargon](https://developers.google.com/style/jargon)*

- Expand an acronym on first use in a document unless it's universally understood in that document's context (e.g., "API" in a developer doc doesn't need expansion; "SLA" in a client doc probably does).
- Avoid jargon the target audience wouldn't already use themselves. A term that's normal in an engineering standup may be jargon in a client-facing document — match the vocabulary to the audience reference file (`developer-documentation.md`, `user-documentation.md`, `client-documentation.md`).

## What good and bad look like

| Avoid | Prefer |
|-------|--------|
| "The configuration file should then be edited by the user in order to set the desired port." | "Edit the configuration file to set the port." |
| "Simply click here to reset your password." | "To reset your password, select **Forgot password**." |
| "This will potentially return an error in some cases." | "This returns a `409 Conflict` error when the resource already exists." |
| "Amazing new caching layer boosts performance!" | "The caching layer reduces average response time from 400 ms to 80 ms." |
| Three synonyms for the same concept across a page ("user," "member," "account holder") | One consistent term, defined once |
