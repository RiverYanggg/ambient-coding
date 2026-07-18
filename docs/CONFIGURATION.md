# 完整配置指南

## 1. 基础环境

### zsh 与 Oh My Zsh

默认 shell 是 zsh，Oh My Zsh 使用 `clean` 主题。当前启用的 Oh My Zsh 内置插件是：

- `git`
- `brew`
- `macos`
- `colored-man-pages`

`zsh-autosuggestions` 通过 Homebrew 单独加载。它根据当前 shell 历史给出灰色建议；它不会把全部命令永久保存到插件自己的数据库，也不会替代 zsh history。历史记录仍由 zsh 的 history 设置和 `~/.zsh_history` 决定。

Tab 行为是个人习惯：有 autosuggestion 时接受建议，没有建议时执行正常补全。

### Ghostty

Ghostty 使用：

- `/bin/zsh -l` 作为登录 shell
- Catppuccin Mocha
- Menlo 14pt，略微加粗并增加 cell 高度
- 夜空山景作为默认背景
- 背景透明度 `0.85`、图片透明度 `0.18`、模糊 `30`
- 25 MB scrollback
- `window-save-state = never`，避免恢复旧 Fish 启动状态

背景图片在 `~/.config/ghostty/backgrounds/`。Ghostty 支持 PNG 和 JPEG；建议使用 1920px 左右宽度、压缩后的图片，避免每个终端实例占用过多显存。

### Maple Mono NF CN

字体通过 Homebrew cask 安装：

```bash
brew install --cask font-maple-mono-nf-cn
```

当前 Ghostty 使用 Menlo，因为本机 Ghostty/CoreText 对 Maple Mono NF CN 的发现和 `@` 字形表现不稳定。可以在 Ghostty 配置中尝试：

```ini
font-family = Maple Mono NF CN
```

如果字体名没有被识别，可在 macOS 字体册中确认显示名称，或使用 Ghostty 的字体查询/日志定位。公式渲染不是字体自动完成的；普通 shell 直接启动 zsh，避免把 `$HOME` 等 shell 文本误判成 LaTeX。需要公式时再显式运行对应的公式工具。

## 2. 工具和用法

### Yazi

输入 `y` 启动 Yazi。退出后 wrapper 会读取临时 cwd 文件，并把 shell 切换到 Yazi 最后访问的目录。

常用操作：

```text
h / l       返回上级目录 / 进入目录
j / k       向下 / 向上移动
Enter       打开文件或目录
q           退出
y           复制选中项
d           删除选中项
r           重命名
Space       选择文件
```

具体键位以当前 Yazi 版本的 `help` 为准。

### lazygit

在 Git 仓库中运行 `lazygit`。它提供 staging、commit、branch、log、rebase 和冲突处理的终端界面。常用按键包括：

```text
Space       stage / unstage
c           commit
p           push
P           pull
Enter       查看详情
Tab         切换面板
q           退出
?           打开帮助
```

### lsd

当前 aliases：

```bash
ls    # lsd
l     # lsd -l
ll    # lsd -l
la    # lsd -la
lt    # lsd --tree --depth=2
```

### jq

当前 aliases：

```bash
jqp   # jq -C .
jqc   # jq -C
```

示例：

```bash
cat package.json | jq '.scripts'
curl -s https://api.github.com/repos/ghostty-org/ghostty | jq '{name, stars: .stargazers_count}'
```

### ripgrep

默认配置位于 `~/.config/ripgrep/config`，启用 smart-case、隐藏文件搜索、行号、列号和标题，并排除 `.git`、`node_modules`、`.venv`。

配置只在 zsh 的 `rg` 函数调用中通过临时环境变量注入，不导出 `RIPGREP_CONFIG_PATH`。这样不会改变 Codex 或其他程序直接调用 `rg` 的环境。

```bash
rg "pattern" .
rg -g '*.ts' "useState" src
```

### fzf

当前机器安装了 fzf，但没有把 `fzf-tab` 或自动补全菜单加载到 zsh。fzf 仍可作为独立命令和其他工具的交互选择器使用；本仓库不依赖 `fzf-tab`。

### uv

uv 用于 Python 解释器、虚拟环境和依赖管理：

```bash
uv venv
source .venv/bin/activate
uv pip install requests
uv run python script.py
uv tool install ruff
```

### tldr

```bash
tldr rg
tldr git
tldr tar
```

它适合快速查看常用命令示例；复杂参数仍以 `man` 或官方文档为准。

### fastfetch

运行 `fastfetch` 查看系统、终端、字体、CPU、GPU、内存和磁盘信息。配置位于 `~/.config/fastfetch/config.jsonc`。

### chezmoi

chezmoi 管理 `.zshrc`、`.zprofile`、`.zshenv`、Ghostty、ripgrep、fastfetch 和背景图。常用流程：

```bash
chezmoi status
chezmoi diff
chezmoi add ~/.zshrc
chezmoi apply
chezmoi update
```

## 3. 不再使用的内容

- Fish
- Oh My Fish
- `fzf-tab`
- 让所有 shell 命令都经过 LaTeX/公式渲染的 wrapper

不再使用的配置不应重新加入迁移仓库。

