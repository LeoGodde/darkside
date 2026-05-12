---
name: interrogate
description: Interrogatório focado do plano do war-room — lê o plano e tech.md, identifica pontos fracos, vagos ou contraditórios, e desafia o usuário com perguntas direcionadas. Reescreve as seções melhoradas diretamente no arquivo do plano.
---

# Interrogate — Plan Refinement

Read a war-room plan, identify weak spots, and grill the user with targeted questions to strengthen the plan. Follow every step in order.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Step 1 — Select the Plan

Check prerequisite `.darkside/holocrons/tech.md`. If missing:

> "O tech.md não foi encontrado. Rode `/explore` primeiro para mapear o projeto."

Look for `-plan.md` files in `.darkside/war-room/`.

**If found:** identify the most recent. Ask:

> "Encontrei um plano recente: **`[filename]`**
>
> É esse que vamos interrogar?
>
> **A.** Sim, usar esse
> **B.** Não, quero informar outro caminho"

- **A:** Read the file in full.
- **B:** Ask for path, read the file.

**If none found:**

> "Nenhum plano encontrado em `.darkside/war-room/`. Rode `/war-room` primeiro."

Stop.

---

## Step 2 — Silent Analysis

Read the entire plan and tech.md. Silently identify:

1. **Vague language** — imprecise, generic wording
2. **Missing details** — sections too short or superficial
3. **Internal contradictions** — conflicts between sections
4. **Unaddressed edge cases** — scenarios mentioned but not covered in the Technical Plan
5. **Gaps with tech.md** — plan assumes something that doesn't match the project
6. **Weak acceptance criteria** — not verifiable or too broad
7. **Missing risk mitigation** — risks without clear mitigation
8. **Ambiguous responsibilities** — unclear which layer owns the logic

Order by severity. Do not share the list — address them one by one.

---

## Step 3 — Interrogation

For each issue, ask **one question at a time**:

1. **Quote the specific part** of the plan
2. **Explain why it's a problem**
3. **Suggest a concrete improvement**

Example:

> O plano diz: *"Erros serão tratados adequadamente."*
>
> Isso é vago demais para implementar. Que tipo de erro pode acontecer aqui? O usuário vê uma mensagem? Tem retry? Tem fallback?
>
> Minha sugestão: definir os 2-3 cenários de erro mais prováveis e o comportamento esperado para cada um.

After a clear answer, immediately rewrite the affected section in the plan file.

If the user disagrees with a valid reason, accept and move on.

If no issues found: say "Analisei o plano em detalhe e não encontrei pontos fracos relevantes. O plano está sólido." and skip to Step 5.

---

## Step 4 — Final Sweep

> "Tem algo que ficou de fora ou que você quer reforçar antes de fecharmos?"

If new point: discuss and update. If not: proceed.

---

## Step 5 — Close

1. Add after the first line of the plan (`✅ Engineering discovery completed`):

   ```
   🔍 Plan refined by /interrogate — DD/MM/YYYY HH:MM
   ```

2. Say:

   > "Interrogatório concluído. Plano refinado e salvo em `.darkside/war-room/<filename>`."
