-- vim: tabstop=2 shiftwidth=2 expandtab
-- macOS-optimized WezTerm configuration

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Safe module loading (fixes dependency issues)
local session_manager_ok, session_manager = pcall(require, "wezterm-session-manager/session-manager")

config.color_scheme = "Tokyo Night"

config.font_size = 14
config.line_height = 1.00

config.animation_fps = 60
config.max_fps = 120
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.term = "xterm-256color"

config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" })
config.font_rules = {
  {
    italic = true,
    font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold", italic = true }),
  },
}
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Command Palette
config.command_palette_font_size = 14
config.command_palette_bg_color = "#1a1b26"  -- Darker Tokyo Night background
config.command_palette_fg_color = "#c0caf5"  -- Tokyo Night foreground

config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0
config.window_decorations = "RESIZE"
config.window_frame = {
	font_size = 14,
}

-- Session manager events (only if module exists)
if session_manager_ok then
	wezterm.on("save_session", function(window)
		session_manager.save_state(window)
	end)
	wezterm.on("load_session", function(window)
		session_manager.load_state(window)
	end)
	wezterm.on("restore_session", function(window)
		session_manager.restore_state(window)
	end)
end

local function move_pane(key, direction)
	return {
		key = key,
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection(direction),
	}
end

local function resize_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize({ direction, 3 }),
	}
end

-- Leader key (CMD+e for macOS)
config.leader = { key = "e", mods = "SUPER", timeout_milliseconds = 2000 }

-- Key bindings optimized for macOS
local keys = {
	-- Word navigation (CMD key for macOS)
	{
		key = "LeftArrow",
		mods = "SUPER", -- Command key for macOS
		action = wezterm.action.SendString("\x1bb"), -- Move back by word
	},
	{
		key = "RightArrow",
		mods = "SUPER", -- Command key for macOS
		action = wezterm.action.SendString("\x1bf"), -- Move forward by word
	},

	-- Pane management (ALT for secondary actions)
	{
		key = "f",
		mods = "ALT",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "v",
		mods = "ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Tab management
	{
		key = "t",
		mods = "ALT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "ALT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.ShowTabNavigator,
	},

	-- Close actions (CMD for primary actions on macOS)
	{
		key = "x",
		mods = "SUPER",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	-- Tab navigation
	{ key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },

	-- Tab selection (direct CMD shortcuts - native macOS style)
	{ key = "1", mods = "SUPER", action = act.ActivateTab(0) },
	{ key = "2", mods = "SUPER", action = act.ActivateTab(1) },
	{ key = "3", mods = "SUPER", action = act.ActivateTab(2) },
	{ key = "4", mods = "SUPER", action = act.ActivateTab(3) },
	{ key = "5", mods = "SUPER", action = act.ActivateTab(4) },
	{ key = "6", mods = "SUPER", action = act.ActivateTab(5) },
	{ key = "7", mods = "SUPER", action = act.ActivateTab(6) },
	{ key = "8", mods = "SUPER", action = act.ActivateTab(7) },
	{ key = "9", mods = "SUPER", action = act.ActivateTab(8) },
	{ key = "0", mods = "SUPER", action = act.ActivateTab(-1) }, -- Last tab

	-- Pane navigation with leader key (vim-style)
	move_pane("j", "Down"),
	move_pane("k", "Up"),
	move_pane("h", "Left"),
	move_pane("l", "Right"),

	-- Resize mode
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes",
			one_shot = false,
			timeout_milliseconds = 2000,
		}),
	},

	-- Send Ctrl+A (useful for tmux/screen)
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},

	-- macOS-specific tmux integration
	{
		key = 's',
		mods = 'CMD',
		action = wezterm.action.SendString('\x1bs'),  -- Alt+s for tmux on macOS
	},

	-- Workspace management
	{
		key = "f",
		mods = "LEADER",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
}

-- Add session manager keys only if module is available
if session_manager_ok then
	table.insert(keys, { key = "S", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_session" }) })
	table.insert(keys, { key = "L", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_session" }) })
	table.insert(keys, { key = "R", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_session" }) })
end

config.keys = keys

config.key_tables = {
	resize_panes = {
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("h", "Left"),
		resize_pane("l", "Right"),
	},
}

-- Mouse bindings
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

return config
