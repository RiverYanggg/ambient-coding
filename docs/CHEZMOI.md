# chezmoi 迁移与使用习惯

## 管理范围

本仓库的 `chezmoi/` 是可迁移 source，管理以下文件：

```text
.zshenv
.zprofile
.zshrc
.config/ghostty/config
.config/ghostty/backgrounds/current.jpg
.config/ghostty/backgrounds/{time,weather,mood,random}/**/*.{jpg,jpeg,png}
.config/ripgrep/config
.config/fastfetch/config.jsonc
```

Ghostty 的背景路径通过 chezmoi 模板渲染为当前用户的 home 目录，不写死原机器用户名。

## 使用习惯

- 先看 `chezmoi status` 和 `chezmoi diff`，确认变更后再 `apply`。
- 新增或修改本机配置后，用 `chezmoi add <path>` 纳入 source。
- 配置应尽可能使用 `$HOME`、Homebrew prefix 和存在性判断。
- 不把 secrets、历史记录和机器特有路径纳入 source。
- zsh 的 `rg` 配置用函数局部注入，保持 Codex 的 `rg` 调用不受全局环境变量影响。
- Tab 用于接受 autosuggestion；没有建议时仍保留普通补全。
- Ghostty 作为主终端，背景图低透明度、低干扰，方便长时间工作。
- Menlo 是当前 Ghostty 默认字体；Maple Mono NF CN 作为已安装备选字体。

## 从本仓库应用

在仓库根目录执行：

```bash
chezmoi --source "$PWD/chezmoi" diff
chezmoi --source "$PWD/chezmoi" apply
```

首次迁移时建议先备份已有配置：

```bash
mkdir -p "$HOME/.terminal-config-backup"
cp -p "$HOME/.zshrc" "$HOME/.zprofile" "$HOME/.zshenv" "$HOME/.terminal-config-backup/" 2>/dev/null || true
```

如果已经把本仓库设置为 chezmoi source，可以直接使用：

```bash
chezmoi source-path
chezmoi diff
chezmoi apply
```

## 跨机器调整

新机器可能没有 conda、nvm 或 OpenClaw。本仓库模板只在对应文件存在时加载这些可选环境；缺失时不会让 zsh 启动失败。Homebrew prefix 使用 `brew --prefix` 或 `brew shellenv`，因此兼容 Apple Silicon 和 Intel macOS。
