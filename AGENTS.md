# AGENTS.md

你正在配置一台 macOS 开发机的终端环境。请遵循本文件和 `docs/` 中的说明，先检查现状，再执行变更。

## 目标状态

- 默认 shell 为 `/bin/zsh`。
- Ghostty 启动 `/bin/zsh -l`。
- Oh My Zsh 使用 `clean` 主题。
- 只启用 `zsh-autosuggestions`；Tab 有建议时接受建议，否则执行普通补全。
- 使用 Yazi shell wrapper，使退出 Yazi 后回到最后访问的目录。
- 使用 lsd aliases、jq helpers 和仅对当前 `rg` 函数生效的 ripgrep 配置。
- 使用 chezmoi 管理 home 配置和 Ghostty 背景图。
- 不安装或配置 Fish、Oh My Fish、`fzf-tab`。

## 执行顺序

1. 阅读 `README.md`、`docs/CONFIGURATION.md` 和 `docs/CHEZMOI.md`。
2. 检查 `uname -s`, `uname -m`, `$SHELL`, `command -v brew`, `chezmoi status`。
3. 运行 `bash scripts/bootstrap.sh`，必要时逐步执行脚本中的命令。
4. 应用配置前运行 `chezmoi --source "$PWD/chezmoi" diff`，不要静默覆盖用户文件。
5. 应用后运行：

   ```bash
   zsh -n ~/.zshrc
   /Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config
   chezmoi status
   ```

6. 若默认 shell 不正确，使用 `chsh -s /bin/zsh`，然后重新打开终端。

## 迁移规则

- 所有路径使用 `$HOME`、`$(brew --prefix)` 或 chezmoi 模板，不要硬编码 `/Users/<name>`。
- 不把 `~/.zsh_history`、密钥、token、私有仓库地址和机器特有环境变量加入仓库。
- `RIPGREP_CONFIG_PATH` 不应全局导出。配置通过 zsh `rg` 函数局部注入，避免改变 Codex 或其他程序调用 rg 的行为。
- 不恢复已经删除的 Fish、Oh My Fish 或 `fzf-tab`。
- 如果当前用户有额外的 conda、nvm 或 OpenClaw 安装，只能通过存在性检查可选加载。
- 编辑文件使用补丁或编辑器；修改后先检查 diff，再应用。

## 交付标准

配置完成必须给出：实际修改的文件、执行过的验证命令、未能验证的部分，以及重新打开 Ghostty 所需的操作。不要声称没有运行过的测试已经通过。

