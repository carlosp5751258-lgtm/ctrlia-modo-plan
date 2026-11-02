# Claude Code plan mode: plan before touching any code

[Leer en español](README.md)

The Spanish version is in the repository root and in [README.md](README.md); the English files are in `en/`.

The files from the Ctrl+IA recipe about plan mode: settings so a project always starts in plan mode and saves plans in the repo, the option to clear context on approval, a prompt template to ask for a good plan and a script that checks nothing is written in plan mode.

The full recipe (Shift+Tab, `/plan`, Ctrl+G, the approval options, `plansDirectory`, `opusplan` and when not to use it):

- English: https://ctrlia.dev/en/recetas/modo-plan.html
- Español: https://ctrlia.dev/recetas/modo-plan.html

## What's included

| File | What for |
| --- | --- |
| `en/.claude/settings.json` | Project settings: `defaultMode: "plan"` and plans saved in `docs/plans` |
| `en/settings-usuario.json` | `showClearContextOnPlanAccept: true` for `~/.claude/settings.json` |
| `en/plantilla-plan.txt` | Planning prompt with goal, context, what not to touch and a "done" criterion |
| `en/probar-modo-plan.sh` | Creates a throwaway repo, asks in plan mode to create `new.txt` and checks it was not created |

## How to use it

```bash
git clone https://github.com/carlosp5751258-lgtm/ctrlia-modo-plan.git
cd ctrlia-modo-plan
mkdir -p /path/to/your-project/.claude
cp en/.claude/settings.json /path/to/your-project/.claude/settings.json   # if you already have one, merge the keys by hand
./en/probar-modo-plan.sh
```

`en/probar-modo-plan.sh` needs `claude` logged in and makes a small request with haiku (it uses a little of your limit). It exits with `0` if the file was not created, `1` if it was and `2` if `claude` failed.

VS Code sessions don't read `defaultMode`: use `claudeCode.initialPermissionMode` in your VS Code user settings.

## What was tested

`python3 -m json.tool` on both settings files, `bash -n` on the script and the script with a fake `claude` in three cases (doesn't write → `0`, writes the file → `1`, fails → `2`). The real test with Claude Code **2.1.316** on Linux (`claude -p --permission-mode plan --model haiku`) did not create the file and saved the plan in `~/.claude/plans`. The interactive part (Shift+Tab, Ctrl+G, approval options, `opusplan`) comes from the official documentation and has not been recorded yet.

## License

MIT. See [LICENSE](LICENSE).

---
Part of **[Ctrl+IA](https://ctrlia.dev/)**: Claude Code like a pro. Made by Carlos P.
