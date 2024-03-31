-- widgets/disk_usage.lua
-- widget to display used space on filesystems (/root and /home)

local wibox = require("wibox")
local awful = require("awful")

local disk_usage_widget = {
   init = function()
      -- declare widget structure
      local spacer = wibox.widget.textbox(" ")
      local root_usage_text = wibox.widget.textbox()
      local home_usage_text = wibox.widget.textbox()
      local widget = wibox.widget {
         root_usage_text,
         spacer,
         home_usage_text,
         layout = wibox.layout.fixed.horizontal
      }
      -- get the GB of usage in the disks
      local get_usage = function(widget_text, dir)
         local command = "df -h " .. dir .. " | awk 'NR==2{print $3}'"
         awful.spawn.easy_async_with_shell(
            command, function(stdout)
               local d = (dir == "/") and "/root" or dir
               local text = string.format(d .. ": %s", stdout:gsub("%s*$", ""))
               widget_text:set_text(text)
            end
         )
      end

      -- set the text
      get_usage(root_usage_text, "/")
      get_usage(home_usage_text, "/home")

      return widget
   end
}

return disk_usage_widget
