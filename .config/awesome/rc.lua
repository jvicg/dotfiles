-- rc.lua
-- main configuration file

-- standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local json = require("json")
pcall(require, "luarocks.loader")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- modules
local bindings = require("modules.bindings")
local defaults = require("modules.defaults")
local rules = require("modules.rules")
local mywibar = require("modules.bar.wibar")
local funcs = require("modules.funcs")

-- error handling
if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        })
end
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true
        naughty.notify(
            {
                preset = naughty.config.presets.critical,
                title = "Oops, an error happened!",
                text = tostring(err)
            })
        in_error = false
    end)
end

-- initial settings
beautiful.init(defaults.paths.theme)                  -- init theme
menubar.utils.terminal = defaults.launchers.terminal  -- set default terminal
funcs.autolock()                                      -- start autolock daemon

-- layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating
}

-- menu
myawesomemenu =
{
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", defaults.launchers.terminal .. " -e man awesome" },
   { "edit config", defaults.launchers.editor .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu(
    {
        items =
            {
                { "awesome", myawesomemenu, beautiful.awesome_icon },
                { "launch terminal", defaults.terminal }
            }
    })

-- launcher (small icon on the left of the bar)
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- default notifications style
naughty.config.defaults.position = beautiful.notification_position
naughty.config.defaults.shape = beautiful.notification_shape

-- desktop environment settings - (one per screen)
awful.screen.connect_for_each_screen(function(s)
    funcs.set_wallpaper(defaults.paths.wall)           -- set wallpaper
    s.mywibox = mywibar(s)                             -- wibox (config at modules/bar/wibar.lua)
    -- s:connect_signal("swapped", function()             -- swapping screens signal
    --     funcs.swap_screens(self, other, is_source)     -- function called after "swapped" signal is caught
    -- end)
end)

-- keybindings - (config at modules/bindings.lua)
root.buttons(bindings.mouse.global)
root.keys(bindings.keyboard.global)

-- rules - (config at modules/rules.lua)
awful.rules.rules = rules

-- client signals
-- signal function to execute when a new client appears
client.connect_signal("manage", function(c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)
-- prevent any client to maximize
client.connect_signal("property::maximized", function(c)
	if c.maximized then
		c.maximized = false
	end
end)
-- enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)
-- change color when client is focused
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- modify default xmodmap
awful.util.spawn_with_shell("xmodmap " .. defaults.paths.home .."/.Xmodmap")
