<div align="center">

# Ghostty Ambient

### 一个完整、可迁移、会随环境变化的 macOS 终端工作区

基于 [Ghostty](https://ghostty.org/)、zsh 和 chezmoi 的终端配置，包含高效命令行工具、快捷操作，以及根据时间、天气、随机策略和心情自动切换背景的 Ghostty Ambient。

<p>
  <a href="https://github.com/RiverYanggg/ambient-coding">GitHub</a> ·
  <a href="docs/CONFIGURATION.md">配置指南</a> ·
  <a href="docs/KEYBINDS.md">快捷键</a> ·
  <a href="AGENTS.md">Agent 规则</a>
</p>

</div>

> **仅支持 macOS**：Ghostty 当前仅支持 macOS，因此本项目无法在 Linux 或 Windows 上运行。

<p align="center">
  <img src="docs/images/showcase/showcase_1.png" alt="Ghostty Ambient workspace background" width="32%" />
  <img src="docs/images/showcase/showcase_2.png" alt="Ghostty Ambient city background" width="32%" />
  <img src="docs/images/showcase/showcase_3.png" alt="Ghostty Ambient snow background" width="32%" />
</p>

## What you get

| Layer | Included |
| --- | --- |
| Terminal | Ghostty、Catppuccin Mocha、透明背景、模糊、分屏和 quick terminal |
| Shell | zsh、Oh My Zsh `clean` 主题、autosuggestion、可靠的 Tab 补全 |
| Navigation | Yazi 文件管理器，退出后自动回到最后访问目录 |
| Git and search | lazygit、ripgrep、fzf、jq、lsd |
| Python and system | uv、tldr、fastfetch |
| Ambient | 时间、天气、心情、随机背景模式，支持本地图片库和持久化默认模式 |
| Reproducibility | Homebrew + chezmoi，配置使用 `$HOME` 和模板，不绑定个人绝对路径 |

## Ambient background system

Ghostty Ambient 是这个工作区的动态背景层。它只更新 Ghostty 的背景图片，不修改终端输出，也不运行常驻 GUI。

| 模式 | 示例 | 行为 |
| --- | --- | --- |
| Time | `--mode time` | 按上午、下午、晚上选择背景 |
| Weather | `--mode weather --weather auto` | 通过 Open-Meteo 映射晴、阴、雨、雪、雷暴 |
| Mood | `--mode mood --mood focus` | 按 `calm`、`focus`、`energy`、`tired`、`happy` 选择 |
| Random | `--mode random` | 从全部本地素材随机选择，避免连续重复 |

背景选择器位于 [`executable_ghostty-time-background`](chezmoi/dot_local/bin/executable_ghostty-time-background)，Ghostty 配置通过 [`config.tmpl`](chezmoi/dot_config/ghostty/config.tmpl) 使用 `current.jpg`，zsh 在 Ghostty shell 启动时自动触发选择。

## Quick start

### Requirements

- macOS（唯一支持的平台）
- [Ghostty](https://ghostty.org/) 1.2.0 或更高版本
- Bash、zsh、curl
- Homebrew（完整安装推荐；Ambient 独立安装不是强制要求）
- `jq`（仅自动天气模式需要）

### Option A: install the complete workspace

适合新机器或希望一次安装全部工具的情况：

```bash
git clone https://github.com/RiverYanggg/ambient-coding.git
cd ambient-coding
bash scripts/bootstrap.sh
```

脚本会安装 Homebrew 依赖、Ghostty、字体和 chezmoi 配置。应用配置前会展示 chezmoi diff，不会使用 `chezmoi apply --force`。

### Option B: install Ambient only

适合已经有 zsh/Ghostty 配置、只想使用动态背景的情况：

```bash
git clone https://github.com/RiverYanggg/ambient-coding.git
cd ambient-coding
bash scripts/install-ambient.sh
source ~/.zshrc
```

Ambient 安装器只安装 CLI 和背景图片，只更新 Ghostty 的 `background-image`，并加入幂等的 Ghostty-only zsh hook，不会替换完整 shell 配置。

不希望安装依赖时：

```bash
bash scripts/install-ambient.sh --no-deps
```

## Try Ambient

所有测试命令都可以加 `--no-reload`，只验证图片选择而不请求 Ghostty 重载：

```bash
# 时间
ghostty-time-background --mode time --time 09:00 --no-reload
ghostty-time-background --mode time --time 13:00 --no-reload
ghostty-time-background --mode time --time 19:00 --no-reload

# 天气
ghostty-time-background --mode weather --weather rain --no-reload
ghostty-time-background --mode weather --weather auto --no-reload

# 心情和随机
ghostty-time-background --mode mood --mood focus --no-reload
ghostty-time-background --mode random --no-reload
```

为新打开的 Ghostty shell 保存默认模式：

```bash
ghostty-time-background --set-mode weather --weather auto
ghostty-time-background --set-mode mood --mood calm
ghostty-time-background --set-mode random
ghostty-time-background --set-mode time
```

当前窗口没有刷新时，按 `Cmd + Shift + ,` 重载 Ghostty。自动重载需要 macOS“隐私与安全性 -> 辅助功能”权限；没有权限时使用快捷键即可。

## Terminal workflow

```text
y                 Yazi 文件管理器
lazygit           Git 图形化终端界面
rg "pattern" .    快速搜索
lsd --tree        查看目录树
jq -C . data.json 彩色格式化 JSON
tldr command      查看常用命令示例
fastfetch         查看系统信息
```

常用快捷键和工具操作见 [`docs/KEYBINDS.md`](docs/KEYBINDS.md)。完整配置、字体、shell、chezmoi 和迁移说明见 [`docs/CONFIGURATION.md`](docs/CONFIGURATION.md) 与 [`docs/CHEZMOI.md`](docs/CHEZMOI.md)。

## Weather and privacy

自动天气模式不需要 API Key：

```text
GHOSTTY_LATITUDE/GHOSTTY_LONGITUDE，或 IP location
  -> Open-Meteo current weather_code
  -> local background directory
```

如需避免 IP 定位，可以指定坐标：

```bash
export GHOSTTY_LATITUDE=31.2304
export GHOSTTY_LONGITUDE=121.4737
ghostty-time-background --mode weather --weather auto
```

项目不读取 macOS Weather App，因为目前没有稳定的公开本地 API。Open-Meteo 免费接口适用于非商业个人使用；商业用途请使用有授权的天气服务并遵守其条款与 attribution 要求。

## Customize images and modes

默认素材按目录分类：

```text
backgrounds/
├── morning/ afternoon/ evening/      # time
├── clear/ cloudy/ rain/ snow/ storm/  # weather
└── calm/ focus/ energy/ tired/ happy/ # mood
```

替换图片或使用外部图片库：

```bash
cp ~/Pictures/my-focus-image.jpg ~/.config/ghostty/backgrounds/focus/
ghostty-time-background --mode mood --mood focus

export GHOSTTY_BACKGROUND_DIR="$HOME/Pictures/ghostty-backgrounds"
ghostty-time-background --mode random
```

支持 `.jpg`、`.jpeg` 和 `.png`。下载的图片请在 [`SOURCES.md`](chezmoi/dot_config/ghostty/backgrounds/SOURCES.md) 中记录来源和授权。

自定义 mood 不是只创建一个目录：当前 CLI 使用显式校验列表，因此新增 `deep-work` 等 mood 时，需要同步更新 CLI 校验、帮助文本、README、素材来源和确定性测试。Agent 会按 [`SKILL.md`](skills/ghostty-ambient-background/SKILL.md) 执行这套流程。

## For Codex and Claude Code

仓库根目录的 [`AGENTS.md`](AGENTS.md) 是统一入口。它要求 agent 先确认 macOS 环境、读取相关文档、检查现有配置和 Git 状态，再根据请求选择：

- 只配置动态背景：使用 `scripts/install-ambient.sh`
- 配置完整终端工作区：使用 `scripts/bootstrap.sh`，并先展示 chezmoi diff
- 扩展背景模式：读取 Skill，更新 CLI、素材目录、来源记录和验证命令

你可以直接这样描述需求：

```text
请阅读 AGENTS.md，配置完整的 macOS 终端工作区。
默认使用天气背景；另外创建一个 deep-work mood，使用我提供的图片。
```

## Project structure

```text
ambient-coding/
├── AGENTS.md                         # Codex / Claude Code 自动化规则
├── README.md                         # 项目总览、安装入口和功能展示
├── LICENSE
├── scripts/
│   ├── bootstrap.sh                  # 完整 macOS 终端工作区安装器
│   └── install-ambient.sh            # 仅安装动态背景的轻量安装器
├── chezmoi/                          # 可迁移的 home 配置 source
│   ├── dot_config/
│   │   └── ghostty/
│   │       ├── config.tmpl           # Ghostty 外观、快捷键和背景配置
│   │       └── backgrounds/          # 时间、天气、心情素材与来源记录
│   ├── dot_local/bin/
│   │   └── executable_ghostty-time-background
│   │                                  # 动态背景选择 CLI
│   ├── dot_zshrc.tmpl                 # zsh、工具别名和启动钩子
│   └── dot_zprofile.tmpl / dot_zshenv.tmpl
├── docs/
│   ├── CONFIGURATION.md               # 完整工具和配置说明
│   ├── KEYBINDS.md                    # Ghostty、zsh、Yazi、lazygit 快捷键
│   ├── CHEZMOI.md                     # 迁移、diff 和 apply 流程
│   ├── SOURCES.md                     # 上游工具资源来源
│   └── images/showcase/               # GitHub README 展示图片
├── skills/
│   └── ghostty-ambient-background/    # 背景配置与扩展 Skill
└── assets/                            # 上游工具预览图和 logo
```

## Project map

| 路径 | 作用 |
| --- | --- |
| `scripts/bootstrap.sh` | 完整 macOS 终端工作区安装器 |
| `scripts/install-ambient.sh` | 仅安装 Ambient 的轻量安装器 |
| `chezmoi/` | 可迁移的 home 配置 source |
| `chezmoi/dot_local/bin/executable_ghostty-time-background` | 动态背景核心 CLI |
| `chezmoi/dot_config/ghostty/config.tmpl` | Ghostty 配置模板 |
| `chezmoi/dot_config/ghostty/backgrounds/` | 默认图片与分类目录 |
| `docs/CONFIGURATION.md` | 完整工具与配置说明 |
| `docs/KEYBINDS.md` | Ghostty、zsh、Yazi、lazygit 快捷键 |
| `docs/CHEZMOI.md` | 迁移、diff 和 apply 流程 |
| `skills/ghostty-ambient-background/` | 背景配置与扩展 Skill |
| `AGENTS.md` | Codex/Claude Code 自动化规则 |

## Safety and license

仓库不保存密码、token、SSH 私钥、命令历史、机器序列号或用户绝对路径。代码使用 MIT License。默认图片仅作为原型素材，发布商业产品前请逐张确认授权，或替换为拥有明确再分发权的素材。
