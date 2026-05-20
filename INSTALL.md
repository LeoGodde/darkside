# Instalação — Darkside Plugin

Passo a passo para habilitar o plugin **Darkside** no Claude Code CLI.

> **Nota:** O comando `claude plugin install` requer um source type ainda não suportado pelo Claude Code.
> Use o script `install.sh` abaixo — ele copia os skills diretamente para `~/.claude/commands/`.

---

## macOS / Linux

### 1. Clonar ou localizar o plugin

Confirme que o diretório do plugin existe:

```bash
ls /caminho/para/darkside/skills/
```

### 2. Executar o instalador

```bash
cd /caminho/para/darkside
bash install.sh
```

Saída esperada:

```
Installing Darkside skills to /Users/<you>/.claude/commands...
  ✔ /darkside
  ✔ /explore
  ✔ /quest
  ✔ /sith-agents
  ✔ /order66
  ✔ /inquisitor
  ✔ /war-room
  ✔ /interrogate
  ✔ /darkside-guide

Done. Open Claude Code and type /darkside to verify.
```

### 3. Testar

Abra o Claude Code em qualquer projeto:

```bash
claude
```

Digite `/darkside` — o logo deve ser exibido.

> O skill `/guide` é instalado como `/darkside-guide` para evitar conflito com outros plugins.

---

## Windows (PowerShell)

### 1. Executar o instalador

```powershell
cd C:\caminho\para\darkside
bash install.sh
```

> Requer Git Bash ou WSL.

---

## Atualizar o plugin

Após mudanças nos arquivos do plugin, execute o instalador novamente — ele sobrescreve os arquivos existentes:

```bash
bash install.sh
```

---

## Desinstalar

```bash
bash uninstall.sh
```

---

## Onde ficam os skills

Os skills são instalados globalmente e ficam disponíveis em todos os projetos:

| Sistema | Caminho |
|---------|---------|
| macOS / Linux | `~/.claude/commands/` |
| Windows | `%APPDATA%\Claude\commands\` |

---

## Resolução de problemas

**Skills não aparecem após o install:**
Reinicie o Claude Code. Algumas mudanças exigem restart para serem carregadas.

**Erro de permissão no `install.sh`:**

```bash
chmod +x install.sh && bash install.sh
```

**`/guide` foi sobrescrito por outro plugin:**
O instalador usa `/darkside-guide` automaticamente para evitar esse conflito.
