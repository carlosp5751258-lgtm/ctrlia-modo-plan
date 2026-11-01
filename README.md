# Modo plan de Claude Code: planifica antes de tocar código

[Read in English](README.en.md)

Los archivos de la receta de Ctrl+IA sobre el modo plan: ajustes para que un proyecto empiece siempre en modo plan y guarde los planes en el repo, la opción de limpiar el contexto al aprobar, una plantilla de prompt para pedir un buen plan y un script que comprueba que en modo plan no se escribe nada.

La receta completa (Shift+Tab, `/plan`, Ctrl+G, las opciones de aprobación, `plansDirectory`, `opusplan` y cuándo no usarlo):

- Español: https://ctrlia.dev/recetas/modo-plan.html
- English: https://ctrlia.dev/en/recetas/modo-plan.html

## Qué incluye

| Archivo | Para qué |
| --- | --- |
| `.claude/settings.json` | Ajustes de proyecto: `defaultMode: "plan"` y planes guardados en `docs/plans` |
| `settings-usuario.json` | `showClearContextOnPlanAccept: true` para `~/.claude/settings.json` |
| `plantilla-plan.txt` | Prompt de planificación con objetivo, contexto, qué no tocar y criterio de «hecho» (en inglés: `plan-template.en.txt`) |
| `probar-modo-plan.sh` | Crea un repo desechable, pide en modo plan crear `nuevo.txt` y comprueba que no se creó |

## Cómo usarlo

```bash
git clone https://github.com/carlosp5751258-lgtm/ctrlia-modo-plan.git
cd ctrlia-modo-plan
mkdir -p /ruta/a/tu-proyecto/.claude
cp .claude/settings.json /ruta/a/tu-proyecto/.claude/settings.json   # si ya tienes uno, junta las claves a mano
./probar-modo-plan.sh
```

`probar-modo-plan.sh` necesita `claude` con la sesión iniciada y hace una petición pequeña con haiku (gasta un poco de tu límite). Termina con `0` si el archivo no se creó, `1` si se creó y `2` si `claude` falló.

Las sesiones de VS Code no leen `defaultMode`: usa `claudeCode.initialPermissionMode` en tus ajustes de usuario de VS Code.

## Qué se probó

`python3 -m json.tool` sobre los dos ajustes, `bash -n` del script y el script con un `claude` falso en tres casos (no escribe → `0`, escribe `nuevo.txt` → `1`, falla → `2`). La prueba real con Claude Code **2.1.316** en Linux (`claude -p --permission-mode plan --model haiku`) no creó el archivo y guardó el plan en `~/.claude/plans`. La parte interactiva (Shift+Tab, Ctrl+G, opciones de aprobación, `opusplan`) sale de la documentación oficial y aún no se ha grabado.

## Licencia

MIT. Ver [LICENSE](LICENSE).

---
Parte de **[Ctrl+IA](https://ctrlia.dev/)**: programa con Claude Code como un pro, en español. Hecho por Carlos P.
