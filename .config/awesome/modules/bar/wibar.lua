-- modules/bar/wibar.lua
-- configuration of the wibar

-- standard awesome libraries
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
-- modules
local defaults = require("modules.defaults")
local bindings = require("modules.bindings")
local wibar_items = require("modules.bar.items")
-- widgets
local spotify_widget = require("widgets.spotify-widget.spotify")
local resources_widget = require("widgets.resources")
local battery_widget = require("widgets.battery-widget.battery")
local disk_usage_widget = require("widgets.disk_usage")
local kernel_widget = require("widgets.kernel")
local ip_widget = require("widgets.ip")

-- wibar init function
local wibar_init = function(s)
    -- wibar items (config at modules/bar/items.lua)
    s.mylayoutbox = wibar_items.layoutbox(s)   -- layoutbox (icon with the selected layout - e.g tile)
    s.mytaglist = wibar_items.taglist(s)       -- taglist (tags with different workspaces)
    s.mytasklist = wibar_items.tasklist(s)     -- tasklist (widget with the name and icon of a client)

    -- wibar config
    local wibar = awful.wibar({ position = "bottom", screen = s, height = 33 }) -- wibar declaration
    wibar:setup
    {
        layout = wibox.layout.align.horizontal,
        expand = "none",                   -- prevent objects in the bar to auto adjust its size

        -- left widgets
        {
            layout = wibox.layout.fixed.horizontal,
            mylauncher,                    -- awesome icon
            defaults.widgets.spacer,       -- spacer
            s.mytaglist,                   -- tag list
            defaults.widgets.spacer_small, -- small spacer
            s.mytasklist,                  -- task list (bar with client name)
        },
        -- middle widgets
        {
            layout = wibox.layout.align.horizontal,
            wibox.widget.textclock()       -- clock widget
        },
        -- right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            defaults.widgets.spacer,       -- spacer
            wibox.widget.systray(),        -- systray (e.g discord icon)
            kernel_widget(),               -- display kernel version on bar
            disk_usage_widget.init(),      -- show usage on filesystems (/home and /)
            ip_widget(),                   -- iface: ip-address
            resources_widget(),            -- cpu and ram usage
            spotify_widget                 -- spotify widget
            (
                { font = beautiful.font, play_icon = beautiful.play_icon,
                pause_icon = beautiful.pause_icon, show_tooltip = false }
            ),
            spacing = 10,                  -- padding
            battery_widget(),              -- icon bat widget TODO: modify widget icons
            defaults.widgets.spacer,       -- spacer
        },
    }
    return wibar
end

return wibar_init
