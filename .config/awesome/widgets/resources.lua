-- widgets/resources.lua
-- widget to display usage of cpu and ram

local wibox = require("wibox")
local awful = require("awful")

local resources_widget = function()

   -- widget structure
   local ram_text = wibox.widget.textbox("ram: 0%  ")
   local cpu_text = wibox.widget.textbox("cpu: 0%")
   local widget = wibox.widget{
      ram_text,
      cpu_text,
      layout = wibox.layout.fixed.horizontal,
   }

   local function update()
      -- update cpu usage
      local function update_cpu()
         local command = "mpstat 1 1 | /bin/grep all | /bin/grep -vi average | awk '{print$NF}' | xargs echo '100 -' | bc | awk '{printf(\"%0.2f\\n\", $0)}'" -- this command returns (100 - free cpu) which is the total usage
         awful.spawn.easy_async_with_shell(command, function(stdout)
            local cpu_usage = string.match(stdout, "%d+%.%d+")
            cpu_text:set_text("cpu: " .. cpu_usage .. "%")
         end)
      end
      -- update ram usage
      local function update_ram()
         awful.spawn.easy_async_with_shell(
            "free -h | /bin/grep -i mem | awk '{print $3}'", function(stdout)
               local ram_usage = string.match(stdout, "(%d+%.?%d*%a)")
               ram_text:set_text("mem: " .. ram_usage .. "  ")
            end)
      end
      update_cpu()
      update_ram()
   end

   -- update the widget initially
   update()

   -- create timer to trigger update function
   local update_timer = timer({ timeout = 1 })
   update_timer:connect_signal("timeout", update)
   update_timer:start()

   return widget
end

return resources_widget
