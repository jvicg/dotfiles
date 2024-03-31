-- widgets/bat_widget.lua
-- widget to display the battery remaining percentage

local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

-- declation
local bat_widget = function()

  -- widget structure
  local text = wibox.widget.textbox()
  local widget = wibox.widget{
     text,
    layout = wibox.layout.fixed.horizontal,
  }

  function update()
      awful.spawn.easy_async_with_shell("acpi", function(stdout)
          battery = string.match(stdout, "(%d+%%)") or "bat.ERROR"
          text:set_text("battery: " .. battery)
      end)
  end

  update()

  -- create timer to update bat percentage
  local update_timer = timer({ timeout = 5 })
  update_timer:connect_signal("timeout", update)
  update_timer:start()

  return widget
end

return bat_widget
