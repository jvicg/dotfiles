-- modules/rules.lua

-- import of libraries
local awful = require("awful")
local beautiful = require("beautiful")
local bindings = require("modules.bindings")
local defaults = require("modules.defaults")
local funcs = require("modules.funcs")

local rules = {

    -- client's window rules
    {
        rule = {},
        properties =
        {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = bindings.keyboard.client,
            buttons = bindings.mouse.client,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- forced floating clients
    {
        rule_any =
        {
            instance =
            {
                "DTA",  -- firefox addon DownThemAll
                "copyq",  -- includes session name in class
                "pinentry",
            },
            class =
            {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm
                "Sxiv",
                "Tor Browser", -- needs a fixed window size to avoid fingerprinting by screen size
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },
            name =
            {
                "Event Tester",  -- xev
            },
            role =
            {
                "AlarmWindow",  -- thunderbird's calendar
                "ConfigManager",  -- thunderbird's about:config
                "pop-up",       -- e.g. google chrome's (detached) developer tools
            }
      },
      properties = { floating = true }
    },

    -- titlebars to normal clients and dialogs
    {
      rule_any = { type = { "normal", "dialog" } },
      properties = { titlebars_enabled = false }
    },

    -- clients with modified window title
    { rule = { class = "Brave-browser" },
      properties = { name = "brave-browser", callback = function(c) funcs.set_windows_title(c, "brave-browser") end } },
    { rule = { class = defaults.launchers.email_client },
      properties = { name = defaults.launchers.email_client, callback = function(c) funcs.set_windows_title(c, defaults.launchers.email_client) end } },
    { rule = { class = "burp-StarBurp" },
      properties = { name = "burp-StartBurp", callback = function(c) funcs.set_windows_title(c, "burpsuite") end } },
}

return rules
