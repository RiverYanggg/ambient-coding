# macOS Terminal Workspace

<div align="center">
  <img src="chezmoi/dot_config/ghostty/backgrounds/night-mountains.jpg" alt="Night mountains Ghostty background" width="960">
  <h3>A calm, portable terminal workspace for macOS</h3>
  <p>Ghostty · zsh · chezmoi · Yazi · lazygit · ripgrep · uv</p>
  <p>
    <a href="https://github.com/RiverYanggg/mac-terminal-workspace/stargazers"><img src="https://img.shields.io/github/stars/RiverYanggg/mac-terminal-workspace?style=flat-square&color=8aadf4" alt="GitHub stars"></a>
    <a href="https://github.com/RiverYanggg/mac-terminal-workspace/blob/main/LICENSE"><img src="https://img.shields.io/github/license/RiverYanggg/mac-terminal-workspace?style=flat-square&color=a6da95" alt="MIT License"></a>
    <a href="https://ghostty.org/"><img src="https://img.shields.io/badge/terminal-Ghostty-c6a0f6?style=flat-square" alt="Ghostty"></a>
  </p>
</div>

<p align="center">
  <img src="chezmoi/dot_config/ghostty/backgrounds/night-city.jpg" alt="Night city Ghostty background" width="31%">
  <img src="chezmoi/dot_config/ghostty/backgrounds/dark-forest.jpg" alt="Dark forest Ghostty background" width="31%">
  <img src="chezmoi/dot_config/ghostty/backgrounds/night-mountains.jpg" alt="Night mountains Ghostty background" width="31%">
</p>

这是一套面向 macOS、Ghostty 和 zsh 的可迁移终端配置。目标是把常用工具、快捷操作和个人使用习惯记录清楚，并让新的机器可以通过 Homebrew + chezmoi 复现。

## 当前方案

- 终端：[Ghostty](https://ghostty.org/)
- Shell：[zsh](https://www.zsh.org/)，[Oh My Zsh](https://ohmyz.sh/) `clean` 主题
- Shell 插件：[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- 文件管理：[Yazi](https://yazi-rs.github.io/)，带 zsh 目录跳转 wrapper
- Git TUI：[lazygit](https://github.com/jesseduffield/lazygit)
- 搜索与数据处理：[ripgrep](https://github.com/BurntSushi/ripgrep)、[jq](https://jqlang.org/)、[fzf](https://github.com/junegunn/fzf)
- 目录列表：[lsd](https://github.com/lsd-rs/lsd)
- 帮助查询：[tealdeer/tldr](https://github.com/tealdeer-rs/tealdeer)
- Python 包与工具：[uv](https://docs.astral.sh/uv/)
- 系统信息：[fastfetch](https://github.com/fastfetch-cli/fastfetch)
- 配置管理：[chezmoi](https://www.chezmoi.io/)
- 字体：[Maple Mono NF CN](https://github.com/subframe7536/maple-font) 已安装；Ghostty 当前使用 Menlo，以保证 `@` 等字符清晰
- Ghostty：Catppuccin Mocha、低透明度背景图、模糊、分屏和快速终端快捷键

Fish、Oh My Fish 和 `fzf-tab` 不属于当前方案，也没有放入本仓库。

## 快速开始

```bash
git clone https://github.com/RiverYanggg/mac-terminal-workspace.git
cd mac-terminal-workspace
bash scripts/bootstrap.sh
```

脚本会安装 Homebrew 依赖并使用本仓库的 `chezmoi/` source 应用配置。它不会覆盖已有文件；chezmoi 对冲突会先提示。

只想查看配置而不应用：

```bash
chezmoi --source "$PWD/chezmoi" diff
```

## 文档导航

- [完整配置指南](docs/CONFIGURATION.md)：安装、配置和日常用法
- [快捷键与操作速查](docs/KEYBINDS.md)：Ghostty、zsh、Yazi、lazygit 和常用命令
- [chezmoi 迁移与习惯](docs/CHEZMOI.md)：文件映射、同步流程和个人偏好
- [来源与依据](docs/SOURCES.md)：工具、插件、主题、字体和配置参考
- [AGENTS.md](AGENTS.md)：让 agent 在新机器上按约定完成配置

## 安全边界

仓库不保存密码、token、SSH 私钥、命令历史、机器序列号或绝对的个人工具路径。`conda`、`nvm` 和 OpenClaw 等可选环境只在本机路径存在时加载。
