# macOS WezTerm Configuration

My WezTerm configuration optimized for macOS, with support for both Apple Silicon and Intel processors.

## Credits & Inspiration
- Session manager: [danielcopper/wezterm-session-manager](https://github.com/danielcopper/wezterm-session-manager)
- Config inspiration: [alexplescan's WezTerm Config](https://alexplescan.com/posts/2024/08/10/wezterm/)
- Workspace setup (currently not working due to right tab status bar): [mwop's WezTerm Usage](https://mwop.net/blog/2024-07-04-how-i-use-wezterm.html)

## Installation

```bash
# Backup existing configuration if present
test -d ~/.config/wezterm && mv ~/.config/wezterm ~/.config/wezterm.bak

# Clone the repository
git clone https://github.com/y37y/wezterm-macos.git ~/.config/wezterm

# Initialize session manager submodule
git submodule update --init --recursive

## Features

- Optimized for macOS
- GPU acceleration with WebGPU frontend
- Session management
- Project management
- Custom keybindings optimized for macOS Command key
- Tokyo Night color scheme

## Configuration Files

- `wezterm.lua`: Main configuration file
- `appearance.lua`: Visual settings and theme configuration
- `projects.lua`: Project management functionality
- `wezterm-session-manager/`: Session management module

## Key Features

### Performance
- WebGPU frontend with high-performance preference
- 60 FPS animations
- 120 max FPS

### Visual
- Tokyo Night color scheme
- JetBrainsMono Nerd Font
- Custom command palette styling
- Borderless window design

### Key Bindings

#### Session Management
- `CMD+e` then `S`: Save session
- `CMD+e` then `L`: Load session
- `CMD+e` then `R`: Restore session

#### Window Management
- `ALT+f`: Toggle pane zoom
- `ALT+v`: Split horizontally
- `ALT+s`: Split vertically
- `CMD+d`: Close current pane
- `CMD+x`: Close current tab

#### Tab Management
- `ALT+t`: New tab
- `ALT+n`: Rename tab
- `ALT+h/l`: Previous/next tab
- `CMD+[number]`: Switch to specific tab
- `CMD+e` then `w`: Show tab navigator

#### Navigation
- `CMD+e` then `h/j/k/l`: Move between panes
- `CMD+LeftArrow/RightArrow`: Move by word
- `CMD+e` then `p`: Project picker
- `CMD+e` then `f`: Workspace fuzzy finder

## Font Configuration
- Font: JetBrainsMono Nerd Font Mono
- Size: 14pt
- Line height: 1.00
- Ligature support enabled

## System Integration
- macOS-optimized key bindings
- Native clipboard support
- Window blur effects (disabled by default)
- Click URLs with CTRL+Click
```
