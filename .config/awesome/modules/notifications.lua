-- modules/notifications.lua

-- import of libaries
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local defaults = require("modules.defaults")

-- notification variables
VOL_UP_MAX_WIDTH = 95
VOL_MUTE_MAX_WIDTH = 150
MAX_HEIGHT = 40

-- module declaration
local notifications = {
  -- volume up and volume down function
  -- called whenever the sound is modified via XF86Audio
  show_volume = function()
    local command = "sleep 0.09 ; pacmd list-sinks | /bin/grep -zo --color=never '* index:.*base volume' | /bin/grep -oaE '[0-9]+\\%' | awk -v RS= '{$1= $1}1' | cut -d ' ' -f 1"
    awful.spawn.easy_async_with_shell(
      command, function(out)
        naughty.notify(
        {
        text = out, icon = beautiful.vol_up_icon,
        font = beautiful.notification_font, timeout = 1, replaces_id = -1,
        position = beautiful.notification_position, max_width = VOL_UP_MAX_WIDTH , max_height = MAX_HEIGHT,
        margin = 10, padding = 10
        })
    end) end,
  -- mute volume function
  -- called whenever the sound is muted via XF86Audio
  show_volume_mute = function()
    local command = "pactl get-sink-mute @DEFAULT_SINK@ | cut -d ' ' -f2 | grep -i 'no'" -- returns either 'no' or ''
    awful.spawn.easy_async_with_shell(command, function(out)
        -- muted case
        if out == '' then
          naughty.notify(
            {
              icon = beautiful.vol_mute_icon, font = beautiful.notification_font, align = "center",
              text = 'sound muted ', timeout = 1, replaces_id = 1,
              position = beautiful.notification_position, max_width = VOL_MUTE_MAX_WIDTH, max_height = MAX_HEIGHT,
              margin = 10, padding = 10
          })
        -- unmuted case
        else
            naughty.notify(
              {
                icon = beautiful.vol_up_icon, text = 'sound on ', font = beautiful.notification_font,
                align = "center", timeout = 1, replaces_id = 1, position = beautiful.notification_position,
                max_width = VOL_MUTE_MAX_WIDTH, max_height = MAX_HEIGHT, margin = 10, padding = 10
              })
        end
  end) end,

  screenshot = function ()
    naughty.notify(
      {
        text = "screenshot saved at " .. defaults.paths.screenshots,
        font = beautiful.notification_font, icon = beautiful.awesome_icon, icon_size = 80,
        max_width = 350, max_height = MAX_HEIGHT,
        timeout = 2, replace_id = 1
      })
    end
}

-- module return
return notifications
