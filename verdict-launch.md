```
██████╗  █████╗ ██████╗ ██╗  ██╗███████╗██╗██████╗ ███████╗
██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██║██╔══██╗██╔════╝
██║  ██║███████║██████╔╝█████╔╝ ███████╗██║██║  ██║█████╗
██║  ██║██╔══██║██╔══██╗██╔═██╗ ╚════██║██║██║  ██║██╔══╝
██████╔╝██║  ██║██║  ██║██║  ██╗███████║██║██████╔╝███████╗
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚═════╝ ╚══════╝
```

---

🏛️ **Novo poder do lado sombrio: `/verdict`**

Quantas vezes uma task foi "concluída" — PR mergeado, deploy feito — mas os critérios de aceite nunca foram verificados de verdade?

Apresentamos o **`/verdict`**: a skill que lê seus cards diretamente do Jira (ou qualquer outra plataforma), extrai os critérios de aceite e **varre o código** para confirmar se cada um deles foi implementado de fato.

---

**O que ele faz:**

✦ Conecta ao Jira via MCP e lê o card completo — campos, comentários, sub-tasks, páginas do Confluence
✦ Extrai os critérios de aceite automaticamente (ou os deriva quando não estão documentados)
✦ Valida cada critério contra o código real, com referência exata de `arquivo:linha`
✦ Classifica cada item como ✅ Completo, ⚠️ Parcial ou ❌ Ausente
✦ Gera um relatório detalhado em `.darkside/verdicts/`

---

**Por que importa:**

Chega de *"acho que tá feito"*. O `/verdict` traz evidência concreta — não opinião, não estimativa. Cada critério verificado com localização no código ou marcado como ausente. Sem ambiguidade.

---

**Como usar:**

```
/verdict
```

Informe o link do card. O resto é automático.
