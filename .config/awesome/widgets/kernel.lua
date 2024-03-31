-- widgets/kernel.lua
-- displays kernel version on wibar

local wibox = require("wibox")
local awful = require("awful")

kernel_widget = function()

   -- widget structure
   local text = wibox.widget.textbox()
   local widget = wibox.widget{
      text,
      layout = wibox.layout.fixed.horizontal
   }

   -- set text with kernel version
   awful.spawn.easy_async_with_shell("uname -r", function(stdout)
      local kernel_version = stdout:gsub("%s*$", "")
      text:set_text(kernel_version)
   end)

   return widget
end

return kernel_widget
