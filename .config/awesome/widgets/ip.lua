-- widgets/ip.lua
-- widget to display the ip address

local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local ip_widget = function()

  -- widget structure
  local text = wibox.widget.textbox() -- ## widget text
  local widget = wibox.widget { -- # widget and layout
      text,
      layout = wibox.layout.fixed.horizontal,
  }

  local function update()
      local command = "ip -o -4 a | awk '{print $2, $4}' | grep -v 'lo'"
      awful.spawn.easy_async_with_shell(command, function(stdout)
          interface, ip_address = string.match(stdout, "(%S+)%s(%d+%.%d+%.%d+%.%d+)%/%d+")
          if interface ~= "docker0" and ip_address then
              text:set_text(interface .. ": " .. ip_address)
          else
              text:set_text("offline")
          end
      end)
  end

  update()

  -- declare a timer to update widget
  local update_timer = timer({ timeout = 15 })
  update_timer:connect_signal("timeout", update)
  update_timer:start()

  return widget
end

return ip_widget
