#!/bin/bash
# Comprueba que en modo plan Claude Code no escribe archivos: crea un repo desechable en /tmp,
# pide crear nuevo.txt en modo plan y mira si el archivo existe.
# Uso: ./probar-modo-plan.sh   (hace una petición pequeña con haiku: gasta un poco de tu límite)
set -euo pipefail
command -v claude >/dev/null || { echo "No encuentro 'claude' en el PATH." >&2; exit 2; }
dir=$(mktemp -d)
trap 'rm -rf "$dir"' EXIT
cd "$dir"
git init -q
if ! claude -p --permission-mode plan --model haiku "Crea el archivo nuevo.txt con el texto hola."; then
  echo "claude -p falló (¿has iniciado sesión?)." >&2; exit 2
fi
if [ -e nuevo.txt ]; then
  echo "FALLO: nuevo.txt existe; el modo plan no bloqueó la escritura." >&2; exit 1
fi
echo "OK: en modo plan no se creó nuevo.txt."
planes="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/plans"
echo "Último plan guardado: $(ls -t "$planes" 2>/dev/null | head -1 || true) (en $planes, o en tu plansDirectory)"
