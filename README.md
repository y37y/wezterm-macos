# macOS WezTerm Configuration

Modern WezTerm configuration optimized for macOS, with support for both Apple Silicon and Intel processors.

## Credits & Inspiration

- Session manager: [danielcopper/wezterm-session-manager](https://github.com/danielcopper/wezterm-session-manager)
- Config inspiration: [alexplescan's WezTerm Config](https://github.com/alexplescan/wezterm-config)

## Installation

### Install WezTerm
```bash
# Using Homebrew (recommended)
brew install --cask wezterm

# Or download directly from GitHub releases
# https://github.com/wez/wezterm/releases
```

### Install Required Font
```bash
# Using Homebrew
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# Or download manually from Nerd Fonts
# https://www.nerdfonts.com/font-downloads
```

### Clone Configuration
```bash
# Backup existing configuration if present
test -d ~/.config/wezterm && mv ~/.config/wezterm ~/.config/wezterm.bak

# Clone the repository
git clone --recursive https://github.com/y37y/wezterm-macos.git ~/.config/wezterm

# Initialize session manager submodule
cd ~/.config/wezterm
git submodule update --init --recursive
```

## Features

### Performance
- **WebGPU frontend** with high-performance preference
- **60 FPS animations** with 120 max FPS
- Optimized for Apple Silicon and Intel Macs

### Visual
- **Tokyo Night color scheme** (hardcoded for consistency)
- **JetBrainsMono Nerd Font** with ligature support
- **Custom command palette** styling
- **Borderless window** design
- **macOS window integration**

### Session Management (Optional)
- Save and restore terminal sessions
- Automatic session persistence
- Multiple session support
- **Note**: Requires `wezterm-session-manager` submodule

## Key Bindings

### Leader Key
- **CMD+e** - Leader key (2-second timeout)

### Session Management
- `CMD+e` then `S` - Save session *(requires session-manager)*
- `CMD+e` then `L` - Load session *(requires session-manager)*
- `CMD+e` then `R` - Restore session *(requires session-manager)*

### Window Management
- `ALT+f` - Toggle pane zoom
- `ALT+v` - Split horizontally
- `ALT+s` - Split vertically
- `CMD+d` - Close current pane
- `CMD+x` - Close current tab

### Tab Management
- `ALT+t` - New tab
- `ALT+n` - Rename tab
- `ALT+h/l` - Previous/next tab
- `CMD+[1-9]` - Switch to specific tab (native macOS style)
- `CMD+0` - Switch to last tab
- `CMD+e` then `w` - Show tab navigator

### Pane Navigation
- `CMD+e` then `h/j/k/l` - Move between panes (vim-style)
- `CMD+e` then `r` - Enter resize mode
  - In resize mode: `h/j/k/l` to resize panes

### Navigation
- `CMD+LeftArrow/RightArrow` - Move by word in terminal
- `CMD+e` then `f` - Workspace fuzzy finder

### System Integration
- `Ctrl+Click` - Open URLs
- `CMD+e` then `Ctrl+a` - Send Ctrl+A (useful for tmux)
- `CMD+s` - Send Alt+s (tmux integration)

## Configuration Files

- `wezterm.lua` - Main configuration
- `wezterm-session-manager/` - Session management module (optional)

## Font Configuration

- **Font**: JetBrainsMono Nerd Font Mono
- **Size**: 14pt
- **Line Height**: 1.00
- **Ligatures**: Enabled (`calt`, `clig`, `liga`)

## macOS Integration

- **Native key bindings** using CMD key for primary actions
- **ALT key** for secondary terminal actions
- **Native clipboard** support
- **URL handling** with Ctrl+Click
- **Window blur effects** (disabled by default for performance)
- **Optimized for Retina displays**

## Troubleshooting

### Missing Session Manager
If session management features don't work:
```bash
cd ~/.config/wezterm
git submodule update --init --recursive
```

### Font Issues
If fonts don't display correctly:
```bash
# Check if font is installed
system_profiler SPFontsDataType | grep -i jetbrains

# Re-install font if needed
brew reinstall --cask font-jetbrains-mono-nerd-font
```

### Performance Issues
If you experience performance problems:
- Try changing `front_end = "OpenGL"` in `wezterm.lua`
- Reduce `max_fps` from 120 to 60
- Enable/disable `macos_window_background_blur`

### Key Binding Conflicts
If shortcuts conflict with macOS:
- Check System Preferences > Keyboard > Shortcuts
- Modify conflicting system shortcuts or WezTerm bindings
