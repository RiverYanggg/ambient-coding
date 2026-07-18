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

## README 图片资源

README 中的功能图不是本机截图，而是从上游项目官方 README 或仓库资源下载的展示素材：

| 本地文件 | 来源 | 用途 |
|---|---|---|
| [`assets/fzf-preview.png`](../assets/fzf-preview.png) | [fzf 官方 README](https://github.com/junegunn/fzf#readme) · [原图](https://raw.githubusercontent.com/junegunn/i/master/fzf-preview.png) | 展示模糊搜索和预览 |
| [`assets/fastfetch-example1.png`](../assets/fastfetch-example1.png) | [fastfetch 官方 README](https://github.com/fastfetch-cli/fastfetch#readme) · [原图](https://raw.githubusercontent.com/fastfetch-cli/fastfetch/dev/screenshots/example1.png) | 展示系统信息布局 |
| [`assets/ghostty-logo.png`](../assets/ghostty-logo.png) | [Ghostty 官方 README](https://github.com/ghostty-org/ghostty#readme) · [原图](https://github.com/user-attachments/assets/fe853809-ba8b-400b-83ab-a9a0da25be8a) | README 品牌识别 |
| [`assets/yazi-logo.png`](../assets/yazi-logo.png) | [Yazi 官方仓库](https://github.com/sxyazi/yazi) · [原图](https://raw.githubusercontent.com/sxyazi/yazi/main/assets/logo.png) | README 品牌识别 |

这些资源的再分发应遵守各自项目仓库中的许可证和品牌使用规则；仓库保留原始项目链接，不把上游图片声明为本项目原创。

## Showcase screenshots

`docs/images/showcase/` 中的图片是本仓库提供的 Ghostty Ambient 展示截图，
用于说明终端文字与背景图叠加后的实际效果。它们不是 Ghostty、Yazi、fzf
或 fastfetch 的官方截图；其中使用的背景素材仍应按照上面的背景来源说明，
在公开发布或商业使用前逐张核对授权和署名要求。
