#!/bin/zsh
# Clean, robust generator for commit messages from STAGED changes using Ollama.
# Works on macOS; copies the message to clipboard and prints it once.

set -euo pipefail

MODEL="${OLLAMA_MODEL:-qwen2.5-coder:7b}"
MAX_CHARS="${AI_COMMIT_MAX_CHARS:-20000}"

echo "[AI Commit] Generating commit message from staged changes..."

# 0) Ensure we're inside a Git repo
if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
  echo "❌ Not a Git repository (run from a repo root)."
  exit 1
fi

# 1) Check staged changes
if git diff --staged --quiet; then
  echo "❌ No staged changes (use 'git add …' and try again)."
  # Exit 0 to avoid scary 'failed task' banners in VS Code
  exit 0
fi

# 2) Check Ollama availability
if ! command -v ollama >/dev/null 2>&1; then
  echo "❌ Ollama CLI not found. Install with 'brew install --cask ollama'."
  exit 1
fi
# Basic server ping
if ! ollama list >/dev/null 2>&1; then
  echo "❌ Ollama server not responding. Start it (open the Ollama app or run 'ollama serve')."
  exit 1
fi

# 3) Collect context
FILES="$(git diff --staged --name-only || true)"
DIFF="$(git diff --staged --no-color -U0 | head -c ${MAX_CHARS} || true)"

if [ -z "${DIFF}" ]; then
  echo "❌ Empty diff for staged changes."
  exit 0
fi

# 4) Build strict prompt (zsh-compatible; avoid bash-only read -d '')
PROMPT=$(cat <<'EOF'
You are a commit message generator following the Conventional Commits spec.

STRICT RULES:
- Base the message ONLY on the provided diff; do NOT invent unrelated changes.
- Output ONLY the final commit message as plain text.
- Do NOT output JSON, YAML, code fences, quotes, or any commentary.
- Language: English.
- Header: <type>(<optional scope>): <subject> (≤72 chars)
  Allowed types: feat, fix, refactor, docs, test, chore, ci, build, perf
- Infer scope from file paths (e.g., auth, ui, api, infra, designRequestForm).
- If only editor/tooling configs changed (e.g., .vscode/*), prefer type "chore" and scope "vscode" or "tooling".
- Body: concise bullets explaining WHAT and WHY (not HOW), grounded in the diff.
- If there are breaking changes, include: BREAKING CHANGE: <description>
- If body is unnecessary, output only the header.
EOF
)

INPUT="${PROMPT}

Staged files:
${FILES}

Diff:
${DIFF}
"

# 5) Run model
if ! RAW="$(OLLAMA_NUM_CTX=8192 ollama run "${MODEL}" "${INPUT}")" || [ -z "${RAW}" ]; then
  echo "❌ Model call failed or returned empty output."
  exit 1
fi

# 6) Normalize trailing whitespace and ensure exactly one newline at end
MSG="$(printf "%s" "${RAW}" | sed -E 's/[[:space:]]+$//')"
printf "%s\n" "${MSG}" | pbcopy

echo "✅ Commit message copied to clipboard"
printf "%s\n" "${MSG}"