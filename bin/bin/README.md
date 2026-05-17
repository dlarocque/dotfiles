# bin

Convenience scripts stowed to `~/bin`. Add `~/bin` to `PATH` (already done in `zsh/.zshrc`).

Conventions:

- One executable per file, no extension (e.g. `mkcd`, not `mkcd.sh`).
- First line: `#!/usr/bin/env bash` (or `python3`, etc).
- `chmod +x` before committing.
- Keep scripts shellcheck-clean.
