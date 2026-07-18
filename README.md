# Ghostty Ambient

让终端根据时间、天气、随机策略和用户心情，自动呈现不同的背景图。

Ghostty Ambient 是一个 macOS 优先的本地工具。它不修改终端输出，也不依赖复杂 GUI；只维护一个 Ghostty 背景图片路径，在打开新 shell 或手动执行命令时选择新的本地素材。

## Features

- **Time mode**：上午、下午、晚上使用不同背景。
- **Weather mode**：通过 Open-Meteo 获取天气，映射为晴、阴、雨、雪、雷暴。
- **Random mode**：从所有素材中随机选择，并避免连续重复。
- **Mood mode**：根据 `calm`、`focus`、`energy`、`tired`、`happy` 选择背景。
- **Persistent default mode**：用户可以设置以后每次打开 Ghostty 默认使用哪种模式。
- **Local-first**：图片缓存到本地，网络失败时仍然可以使用已有素材。
- **Customizable**：可以添加自己的图片目录、创建新模式素材，或替换现有图片。
- **Agent-ready**：仓库包含 `AGENTS.md` 和 `skills/ghostty-ambient-background`，Codex 或 Claude Code 可以按项目规则完成自动配置。

## Preview

默认素材按以下目录组织：

```text
backgrounds/
├── morning/       # time
├── afternoon/     # time
├── evening/       # time
├── clear/         # weather
├── cloudy/
├── rain/
├── snow/
├── storm/
├── calm/          # mood
├── focus/
├── energy/
├── tired/
└── happy/
```

## Requirements

- macOS
- [Ghostty](https://ghostty.org/)
- Bash、zsh、curl
- `jq`：仅自动天气模式需要；安装脚本会在 Homebrew 可用时安装
- Homebrew：推荐，用于自动安装依赖

Ghostty 需要支持 `background-image`，建议使用 Ghostty 1.2.0 或更高版本。

## Quick Start

### 1. Clone

```bash
git clone https://github.com/RiverYanggg/ambient-coding.git
cd ambient-coding
```

### 2. Install

```bash
bash scripts/install-ambient.sh
source ~/.zshrc
```

安装脚本会：

1. 检查 Ghostty；如果检测到 Homebrew，会尝试安装缺失的 Ghostty 和 `jq`。
2. 将图片复制到 `~/.config/ghostty/backgrounds/`。
3. 将 `ghostty-time-background` 安装到 `~/.local/bin/`。
4. 只更新 Ghostty 配置中的 `background-image` 行，不覆盖其他 Ghostty 设置。
5. 在 `~/.zshrc` 中加入幂等的 Ghostty 启动钩子。

不希望脚本安装依赖时：

```bash
bash scripts/install-ambient.sh --no-deps
```

### 3. Test

```bash
# 模拟时间
ghostty-time-background --mode time --time 09:00
ghostty-time-background --mode time --time 13:00
ghostty-time-background --mode time --time 19:00

# 手动天气
ghostty-time-background --mode weather --weather rain
ghostty-time-background --mode weather --weather snow

# 自动天气
ghostty-time-background --mode weather --weather auto

# 心情和随机
ghostty-time-background --mode mood --mood focus
ghostty-time-background --mode random
```

当前窗口没有刷新时，按 Ghostty 的配置重载快捷键：

```text
Cmd + Shift + ,
```

脚本也会尝试自动触发该快捷键。macOS 可能要求在“系统设置 -> 隐私与安全性 -> 辅助功能”中允许运行脚本的终端应用控制 Ghostty。

### 4. Choose a default mode

```bash
# 之后每次打开 Ghostty 都使用自动天气
ghostty-time-background --set-mode weather --weather auto

# 之后每次打开 Ghostty 都使用随机背景
ghostty-time-background --set-mode random

# 之后每次打开 Ghostty 都使用心情模式
ghostty-time-background --set-mode mood --mood calm

# 恢复默认的时间模式
ghostty-time-background --set-mode time
```

默认模式保存在：

```text
~/.config/ghostty-time-background/mode
```

心情和天气偏好分别保存在同目录下的 `mood` 和 `weather` 文件中。

## Weather and API policy

默认天气模式不需要 API Key：

```text
IP location -> Open-Meteo -> weather code -> local image
```

Open-Meteo 的免费接口适用于非商业使用，官方限制为每天少于 10,000 次、每小时 5,000 次、每分钟 600 次请求，并要求遵守 CC BY 4.0。商业产品请使用你自己申请的商业天气 API 或 Open-Meteo 商业方案，不要把 API Key 写入仓库。

如果不希望使用 IP 定位，可以指定经纬度：

```bash
export GHOSTTY_LATITUDE=31.2304
export GHOSTTY_LONGITUDE=121.4737
ghostty-time-background --mode weather --weather auto
```

当前实现不直接读取 macOS Weather App；macOS 没有稳定公开的本地天气读取接口。

## Customize

### Replace an image

把自己的图片放入对应目录：

```bash
cp ~/Pictures/my-focus-image.jpg ~/.config/ghostty/backgrounds/focus/
ghostty-time-background --mode mood --mood focus
```

支持 `.jpg`、`.jpeg` 和 `.png`。建议使用宽度约 1600-1920px 的压缩图片，避免 Ghostty 每个终端实例占用过多显存。

### Create a new mood

当前 CLI 的 mood 名称由脚本校验。如果要创建新 mood，例如 `deep-work`：

1. 在 `backgrounds/deep-work/` 放入图片。
2. 在 `ghostty-time-background` 的 mood 校验列表中加入 `deep-work`。
3. 在 `usage` 和 README 中补充名称。
4. 运行 shell 语法检查和实际模式测试。

### Add a new time period

时间模式的选择逻辑位于：

```text
chezmoi/dot_local/bin/executable_ghostty-time-background
```

可以把当前三段扩展为清晨、工作时段、黄昏、深夜等更细粒度区间，并为每个区间创建同名目录。

### Use a custom image library

```bash
export GHOSTTY_BACKGROUND_DIR="$HOME/Pictures/ghostty-backgrounds"
ghostty-time-background --mode random
```

目录结构与仓库的 `backgrounds/` 相同即可。

## Agent automation

如果你使用 Codex 或 Claude Code，可以直接在仓库目录运行：

```text
请阅读 AGENTS.md，并根据我的偏好配置 Ghostty Ambient。
我希望默认使用天气模式，心情模式支持 calm、focus、deep-work。
```

仓库中的 agent skill 位于：

```text
skills/ghostty-ambient-background/SKILL.md
```

它会指导 agent：

- 检查操作系统、Ghostty、jq、curl 和现有配置；
- 先查看 chezmoi diff，避免静默覆盖用户配置；
- 根据用户描述选择或创建模式；
- 询问并使用用户自己申请的 API Key；
- 配置天气经纬度、图片目录和默认模式；
- 运行 Ghostty 配置校验、shell 语法检查和模式测试。

## Files

- `scripts/install-ambient.sh`：只安装 Ambient 功能的安装器
- `chezmoi/dot_local/bin/executable_ghostty-time-background`：核心 CLI
- `chezmoi/dot_config/ghostty/config.tmpl`：Ghostty 配置模板
- `chezmoi/dot_config/ghostty/backgrounds/`：默认素材和分类目录
- `docs/CONFIGURATION.md`：详细配置说明
- `AGENTS.md`：给 Codex、Claude Code 等 agent 的自动化规则
- `skills/ghostty-ambient-background/`：专用 agent skill

仓库还保留了完整 macOS 终端工作区配置。如果你想安装 Yazi、lazygit、fastfetch 等全部工具，可以查看 `scripts/bootstrap.sh`；只想使用本项目的动态背景功能，请使用 `scripts/install-ambient.sh`。

## License and image rights

代码使用 MIT License。默认图片仅作为原型素材，来源和下载地址记录在 [backgrounds/SOURCES.md](chezmoi/dot_config/ghostty/backgrounds/SOURCES.md)。发布商业产品前，请逐张确认图片当前授权和 attribution 要求，或替换为你拥有明确再分发权的素材。
