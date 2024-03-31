-- modules/funcs.lua
-- module with different useful functions

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local defaults = require("modules.defaults")

local funcs = {

    set_wallpaper = function(wall)
        awful.util.spawn_with_shell("feh --bg-scale " .. wall .. " --output eDP1")
        awful.util.spawn_with_shell("feh --bg-scale " .. wall .. " --output HDMI1")
    end,

    -- change client's name whenever it's tries to autorename
    -- (e.g if brave change its name to Brave - Youtube - BlaBla.. - it will go back to brave-browser)
    set_windows_title = function(c, name)
        c:connect_signal("property::name", function()
            c.name = name
        end)
    end,

    -- lockscreen whenever lid is close
    autolock  = function () -- lock laptop when lid is closed
        awful.spawn.with_line_callback("acpi_listen", {
            stdout = function(line)
                if string.match(line, "button/lid LID close") then
                    awful.util.spawn_with_shell(defaults.launchers.screenlocker)
                end
            end
        })
    end,

    -- update overline colors when client is selected
    update_color = function(self, c, index, tags)
        -- get selected tag
        local focused = false
        for _, x in pairs(tags) do
            if x.index == index then
                focused = true
                break
            end
        end
        -- change color to selected tag
        if focused then
            self:get_children_by_id("overline")[1].bg = beautiful.underline_color
        else
            self:get_children_by_id("overline")[1].bg = beautiful.bg_normal
        end
    end,

    -- swap content between screens - this will be called after "swapped" signal is caught
    -- TODO: depure code and check functionality
    swap_screens = function(self, other, is_source)
        if not is_source then return end
        local st = self.selected_tag
        local sc = st:clients()
        local ot = other.selected_tag
        local oc = ot:clients()

        for _, c in ipairs(sc) do c:move_to_tag(ot) end
        for _, c in ipairs(oc) do c:move_to_tag(st) end
    end,
}

return funcs
