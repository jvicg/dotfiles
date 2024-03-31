-- modules/bar/items.lua
-- all the config relation to the wibar
-- this config includes tasklist and taglist, between others

-- import of libraries
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local defaults = require("modules.defaults")
local bindings = require("modules.bindings")
local funcs = require("modules.funcs")

local wibar = {
    -- tags (widget with the different workspaces)
    taglist = function(s)
        awful.tag(beautiful.tags, s, awful.layout.layouts[1]) -- tags declaration (tags are modified on theme file)
        return awful.widget.taglist(
            {
                screen  = s,
                filter  = awful.widget.taglist.filter.all,
                buttons = bindings.taglist_mouse,
                style = { font = beautiful.tags_font }, -- tag widget font
                widget_template = {
                    {
                        {
                            layout = wibox.layout.fixed.vertical,
                            { -- overline widget - it will change its color when tag is selected
                                {
                                    left = 20,   -- overline X-left position
                                    right = 15,  -- overline X-right
                                    top = 4,     -- overline Y-top position
                                    widget = wibox.container.margin
                                },
                                id = 'overline',
                                bg = beautiful.bg_normal,
                                shape = gears.shape.rectangle, -- overline shape
                                widget = wibox.container.background
                            },
                            { -- tag widget
                                {
                                    id = 'text_role',
                                    widget = wibox.widget.textbox,
                                },
                                left = 15, -- inside tag X position - (this will act as padding)
                                top = 7,   -- inside tag Y position
                                widget = wibox.container.margin
                            },
                        },
                        left = 1,   -- outside tag X-left position - (this will act as space between tags)
                        right = 15, -- outside tag X-right position
                        widget = wibox.container.margin
                    },
                    id = 'background_role',
                    widget = wibox.container.background,
                    shape = gears.shape.rectangle,

                    -- callbacks to change and update overline color when tag is selected
                    create_callback = function(self, c, index) funcs.update_color(self, c, index, s.selected_tags) end,
                    update_callback = function(self, c, index) funcs.update_color(self, c, index, s.selected_tags) end,
                }
            }
        ) end,

    -- tasklist (which is the widget which the icon and the name of a client)
    tasklist = function(s)
        return awful.widget.tasklist
        (
            {
                screen  = s,
                filter  = awful.widget.tasklist.filter.currenttags,
                buttons = bindings.tasklist_mouse,
                widget_template =
                    {
                        {
                            layout = wibox.layout.fixed.vertical,
                            { -- overline widget (line over tasks when selected)
                                {
                                    left = 25,   -- overline X-left position
                                    right = 25,  -- overline X-right position
                                    bottom = 5,  -- overline Y-bottom position
                                    widget = wibox.container.margin,
                                },
                                id = "overline_task",
                                bg = beautiful.underline_color,
                                shape = gears.shape.rectangle,
                                widget = wibox.container.background
                            },
                            { -- task widget
                                layout = wibox.layout.fixed.horizontal,
                                { -- icon
                                    {
                                        id = "icon_role",
                                        widget = wibox.widget.imagebox,
                                        resize = true,
                                        forced_width = 20 -- icon size
                                    },
                                    margins = 5, -- margins between icon and borders
                                    widget = wibox.container.margin
                                },
                                { -- text
                                    id = "text_role",
                                    widget = wibox.widget.textbox,
                                },
                            },
                        }, -- background
                        id = "background_role",
                        widget = wibox.container.background,
                        shape = gears.shape.rectangle,

                    -- callback function - called whenever an action is done
                        update_callback = function(self, c, index, objects)
                            if c == client.focus then
                                self:get_children_by_id("overline_task")[1].bg = beautiful.underline_color
                            else
                                self:get_children_by_id("overline_task")[1].bg = beautiful.bg_normal
                            end
                        end
                    },
            }
        )
    end,

    -- create an imagebox widget which will contain an icon indicating which layout we're using
    layoutbox = function(s)
        local lb = awful.widget.layoutbox(s)
        lb:buttons(gears.table.join
                   (
                        awful.button({ }, 1, function () awful.layout.inc( 1) end),
                        awful.button({ }, 3, function () awful.layout.inc(-1) end),
                        awful.button({ }, 4, function () awful.layout.inc( 1) end),
                        awful.button({ }, 5, function () awful.layout.inc(-1) end)
                   ))
        return lb
    end,

}

return wibar
