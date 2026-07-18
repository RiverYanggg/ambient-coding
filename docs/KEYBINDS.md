# 快捷键与操作速查

## Ghostty

| 快捷键 | 操作 |
|---|---|
| `Cmd+T` | 新建 tab |
| `Cmd+Shift+Left` | 上一个 tab |
| `Cmd+Shift+Right` | 下一个 tab |
| `Cmd+W` | 关闭当前 surface |
| `Cmd+D` | 向右新建 split |
| `Cmd+Shift+D` | 向下新建 split |
| `Cmd+Alt+Left/Right/Up/Down` | 在 split 间移动 |
| `Cmd+Shift+F` | 当前 split 全屏/恢复 |
| `Cmd+Shift+E` | 均分 splits |
| `Cmd++` | 增大字体 |
| `Cmd+-` | 减小字体 |
| `Cmd+0` | 重置字体大小 |
| `Cmd+Shift+,` | 重载 Ghostty 配置 |
| `Ctrl+Grave Accent` | 切换 quick terminal |

Ghostty 还启用了选中即复制、输入时隐藏鼠标、粘贴保护和 bracketed paste。

## zsh

| 操作 | 说明 |
|---|---|
| `Tab` | 有 autosuggestion 时接受建议，否则普通补全 |
| `Ctrl+R` | 使用 zsh 历史反向搜索，具体表现取决于当前 zsh 配置 |
| `history` | 查看 shell 历史 |
| `source ~/.zshrc` | 重新加载 zsh 配置 |

## Yazi

| 按键 | 操作 |
|---|---|
| `h` / `l` | 返回上级 / 进入目录 |
| `j` / `k` | 向下 / 向上移动 |
| `Enter` | 打开 |
| `Space` | 选择 |
| `q` | 退出并回到最后访问目录 |
| `?` | 打开 Yazi 帮助 |

## lazygit

| 按键 | 操作 |
|---|---|
| `Space` | stage / unstage |
| `c` | commit |
| `p` | push |
| `P` | pull |
| `Tab` | 切换面板 |
| `?` | 帮助 |
| `q` | 退出 |

## 命令速查

```bash
y                 # Yazi
lazygit           # Git TUI
lsd --tree        # 目录树
rg "text" .       # 搜索
jq -C . data.json # 彩色格式化 JSON
tldr command      # 简短命令示例
fastfetch         # 系统信息
```

