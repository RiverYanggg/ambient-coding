# 来源与依据

本页区分“软件官方来源”和“本仓库的本地设计”。链接优先指向项目官网、官方文档或官方仓库。

## 工具与插件

| 项目 | 用途 | 官方来源 | 本仓库采用的部分 |
|---|---|---|---|
| Ghostty | 终端模拟器 | [ghostty.org](https://ghostty.org/) · [配置参考](https://ghostty.org/docs/config/reference) | zsh 启动、主题、背景图、透明度、分屏和快捷键 |
| zsh | 默认 shell | [zsh.org](https://www.zsh.org/) · [文档](https://zsh.sourceforge.io/Doc/) | 登录 shell、补全和 Tab 行为 |
| Oh My Zsh | zsh 配置框架 | [ohmyz.sh](https://ohmyz.sh/) · [GitHub](https://github.com/ohmyzsh/ohmyzsh) | `clean` 主题和 `git`、`brew`、`macos`、`colored-man-pages` |
| zsh-autosuggestions | 命令建议 | [GitHub](https://github.com/zsh-users/zsh-autosuggestions) | 灰色建议；Tab 接受建议 |
| Yazi | 文件管理器 | [官网](https://yazi-rs.github.io/) · [GitHub](https://github.com/sxyazi/yazi) | 官方 shell wrapper 思路和常用快捷键 |
| lazygit | Git TUI | [GitHub](https://github.com/jesseduffield/lazygit) · [Keybindings](https://github.com/jesseduffield/lazygit/blob/main/docs/keybindings.yml) | 交互式 staging、commit、branch 和 log |
| fzf | 模糊选择器 | [GitHub](https://github.com/junegunn/fzf) | 保留 CLI 工具；不启用 `fzf-tab` shell 集成 |
| ripgrep | 文本搜索 | [GitHub](https://github.com/BurntSushi/ripgrep) · [Guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md) | smart-case、hidden、行列号和目录排除 |
| jq | JSON 处理 | [官网](https://jqlang.org/) · [Manual](https://jqlang.org/manual/) | `jqp`、`jqc` aliases |
| lsd | 目录列表 | [GitHub](https://github.com/lsd-rs/lsd) | `ls`、`l`、`ll`、`la`、`lt` aliases |
| tealdeer | tldr 客户端 | [GitHub](https://github.com/tealdeer-rs/tealdeer) | `tldr` 快速查例 |
| uv | Python 工具链 | [官方文档](https://docs.astral.sh/uv/) · [GitHub](https://github.com/astral-sh/uv) | venv、依赖和 tool workflow |
| fastfetch | 系统信息 | [GitHub](https://github.com/fastfetch-cli/fastfetch) | JSONC module 配置 |
| chezmoi | dotfiles 管理 | [官网](https://www.chezmoi.io/) · [GitHub](https://github.com/twpayne/chezmoi) | home 文件、Ghostty、背景图和工具配置 |
| Homebrew | macOS 包管理 | [brew.sh](https://brew.sh/) · [Formulae](https://formulae.brew.sh/) | 安装公式、cask 和 zsh 插件 |

## 主题与字体

| 项目 | 用途 | 官方来源 | 本仓库采用的部分 |
|---|---|---|---|
| Catppuccin | Ghostty 配色主题 | [官网](https://catppuccin.com/) · [GitHub](https://github.com/catppuccin/catppuccin) | `Catppuccin Mocha` |
| Maple Mono | 中文编程字体 | [Maple Font GitHub](https://github.com/subframe7536/maple-font) | 安装 `Maple Mono NF CN` 作为备选字体 |

## 配置依据

- Ghostty 配置键和行为以 [官方配置参考](https://ghostty.org/docs/config/reference) 为准。
- Yazi wrapper 以 [Yazi 官方 shell wrapper 文档](https://yazi-rs.github.io/docs/quick-start/) 为依据，再按 zsh 调整。
- autosuggestion 的接受动作来自 [zsh-autosuggestions widget 文档](https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md)。
- ripgrep 配置格式和 flag 以 [ripgrep GUIDE](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md) 与 `rg --help` 为准。
- Homebrew 安装方式以 [Homebrew 官方文档](https://docs.brew.sh/) 为准。
- 用户最初提供的 Ghostty gist 作为早期配置参考：<https://gist.githubusercontent.com/zhangchitc/7dead7c1b517390e061e07759ed80277/raw/ea3aab07d17f8bb961081cd03e177ff36d0862c8/gistfile1.txt>

## 背景图片说明

`chezmoi/dot_config/ghostty/backgrounds/` 中的三张 JPEG 是本仓库随配置保存的压缩背景资源。当前 JPEG 元数据没有保留原始摄影作者和下载 URL，因此这里不虚构具体署名；重新公开分发或替换图片时，应核对原始素材的许可，并在此表中补充准确来源。

