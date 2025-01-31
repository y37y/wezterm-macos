-- vim: tabstop=2 shiftwidth=2 expandtab

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local appearance = require("appearance")
local projects = require("projects")
local session_manager = require("wezterm-session-manager/session-manager")

config.color_scheme = "Tokyo Night"

config.font_size = 14
config.line_height = 1.00

config.animation_fps = 60
config.max_fps = 120
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.term = "xterm-256color"

config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Regular" })
config.font_rules = {
  {
    italic = true,
    font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Bold", italic = true }),
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

-- Make it look like tabs, with better GUI controls - buggy
-- wezterm.config.use_fancy_tab_bar = true

--[[
-- workspace server
konfig.unix_domains = {
	{
		name = "unix",
	},
}
]]

config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0
config.window_decorations = "RESIZE"
config.window_frame = {
	font_size = 14,
}

-- wezterm session manager
wezterm.on("save_session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)

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

config.leader = { key = "e", mods = "SUPER", timeout_milliseconds = 2000 }

-- Table mapping keypresses to actions
config.keys = {
	-- wezterm session manager
	{ key = "S", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_session" }) },
	{ key = "L", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_session" }) },
	{ key = "R", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_session" }) },

	-- wezterm workspace little different from project buggy maybe bc of top right status bar
	--[[
	-- Attach to muxer
	{
		key = "a",
		mods = "LEADER",
		action = act.AttachDomain("unix"),
	},

	-- Detach from muxer
	{
		key = "s",
		mods = "LEADER",
		action = act.DetachDomain({ DomainName = "unix" }),
	},
  ]]

	-- Sends ESC + b and ESC + f sequence, which is used
	-- for telling your shell to jump back/forward.
	{
		key = "LeftArrow",
		mods = "SUPER", -- Command (SUPER) key for macOS
		action = wezterm.action.SendString("\x1bb"), -- Move back by word
	},
	{
		key = "RightArrow",
		mods = "SUPER", -- Command (SUPER) key for macOS
		action = wezterm.action.SendString("\x1bf"), -- Move forward by word
	},

	-- zoom in and out pane
	{
		key = "f",
		mods = "ALT",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- create a new tab
	{
		key = "t",
		mods = "ALT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},

	-- rename a tab
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

	-- show tab navigator
	{
		key = "w",
		mods = "LEADER",
		action = act.ShowTabNavigator,
	},

	-- close a tab also ctrl + d works in termianl
	{
		key = "x",
		mods = "SUPER",
		action = act.CloseCurrentTab({ confirm = true }),
	},

	-- close current pane
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	-- move between tabs
	{ key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },

	-- Tab selection default is already SUPER + num (macos is command + num)
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },
	{ key = "0", mods = "LEADER", action = act.ActivateTab(-1) }, -- Last tab

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
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},

	move_pane("j", "Down"),
	move_pane("k", "Up"),
	move_pane("h", "Left"),
	move_pane("l", "Right"),

	{
		-- When we push LEADER + R...
		key = "r",
		mods = "LEADER",
		-- Activate the `resize_panes` keytable
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes",
			-- Ensures the keytable stays active after it handles its
			-- first keypress.
			one_shot = false,
			-- Deactivate the keytable after a timeout.
			timeout_milliseconds = 2000,
		}),
	},
	{
    key = 's',
    mods = 'CMD',
    action = wezterm.action.SendString('\x1bs'),  -- Alt+s for tmux on MacOS
  },
	{
		key = "p",
		mods = "LEADER",
		-- Present in to our project picker
		action = projects.choose_project(),
	},
	{
		key = "f",
		mods = "LEADER",
		-- Present a list of existing workspaces
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
}

config.key_tables = {
	resize_panes = {
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("h", "Left"),
		resize_pane("l", "Right"),
	},
}

-- Mouse bindings (from Omerxx's config)
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

return config
