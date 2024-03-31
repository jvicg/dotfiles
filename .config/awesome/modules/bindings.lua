-- modules/bindings.lua

-- import of libraries
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
local defaults = require("modules.defaults")
local notifications = require("modules.notifications")

-- module declaration
local bindings = {}

-- mouse functions for taglist nd tasklists
bindings.taglist_mouse = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ defaults.modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ defaults.modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end))

bindings.tasklist_mouse = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- mouse bindings
bindings.mouse = {
    -- global bindings
    global = gears.table.join(
        awful.button({ }, 3, function () mymainmenu:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)),
    -- client bindings
    client = gears.table.join(
        awful.button({ }, 1, function (c)
                c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
        awful.button({ defaults.modkey }, 1, function (c)
                c:emit_signal("request::activate", "mouse_click", {raise = true})
                awful.mouse.client.move(c) end),
        awful.button({ defaults.modkey }, 3, function (c)
                c:emit_signal("request::activate", "mouse_click", {raise = true})
                awful.mouse.client.resize(c) end))
}


-- keyboard bindings
bindings.keyboard = {
    -- global bindings
  global = gears.table.join(
    -- movement && hotkeys help menu
    awful.key({ defaults.modkey }, "s", hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ defaults.modkey }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ defaults.modkey }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ defaults.modkey }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ defaults.modkey }, "j",
        function ()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ defaults.modkey }, "space",
        function ()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ defaults.modkey }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- layout manipulation
    awful.key({ defaults.modkey, "Shift" }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ defaults.modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ defaults.modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ defaults.modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ defaults.modkey }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ defaults.modkey }, "Up",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ defaults.modkey }, "Down",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ defaults.modkey, "Shift" }, "Up",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ defaults.modkey, "Shift" }, "Down",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ defaults.modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ defaults.modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ defaults.modkey, "Control"  }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ defaults.modkey, "Shift" }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
    awful.key({ defaults.modkey }, "g",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ defaults.modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- reload and quit functions
    awful.key({ defaults.modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ defaults.modkey, "Shift" }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

      -- launchers
    awful.key({ defaults.modkey }, "Return", function () awful.spawn(defaults.launchers.terminal) end,
              {description = "runs" .. defaults.launchers.terminal, group = "launcher"}),
    awful.key({ defaults.modkey }, "'" , function () awful.util.spawn(defaults.launchers.program_launcher .. " options -theme " .. defaults.launchers.rofi_theme .. " -show drun") end,
              {description = "runs rofi", group = "launcher"}),
    awful.key({ defaults.modkey, "Control" }, "b", function () awful.util.spawn(defaults.launchers.navigator_private) end,
              {description = "runs " .. defaults.launchers.navigator .. " as incognito", group = "launcher"}),
    awful.key({ defaults.modkey }, "b", function () awful.util.spawn(defaults.launchers.navigator) end,
              {description = "runs " .. defaults.launchers.navigator, group = "launcher"}),
    awful.key({ defaults.modkey }, "d", function () awful.util.spawn(defaults.launchers.discord) end,
              {description = "runs " .. defaults.launchers.discord, group = "launcher"}),
    awful.key({ defaults.modkey }, "p", function () awful.util.spawn(defaults.launchers.password_manager) end,
              {description = "runs " .. defaults.launchers.password_manager, group = "launcher"}),
    awful.key({ defaults.modkey }, "c", function () awful.util.spawn(defaults.launchers.editor) end,
              {description = "runs " .. defaults.launchers.editor, group = "launcher"}),
    awful.key({ defaults.modkey }, "g", function () awful.util.spawn(defaults.launchers.file_manager) end,
              {description = "runs " .. defaults.launchers.file_manager, group = "launcher"}),
    awful.key({ defaults.modkey }, "v", function () awful.util.spawn(defaults.launchers.hypervisor) end,
              {description = "runs " .. defaults.launchers.hypervisor, group = "launcher"}),
    awful.key({ defaults.modkey, "Control" }, "v", function () awful.util.spawn(defaults.launchers.vbox) end,
              {description = "runs VirtualBox", group = "launcher"}),
    awful.key( { defaults.modkey }, "º", function () awful.util.spawn(defaults.launchers.sound_manager) end,
              {description = "runs " .. defaults.launchers.sound_manager, group = "launcher"}),
    awful.key({ defaults.modkey }, "q", function () awful.spawn(defaults.launchers.screenlocker) end,
              {description = "runs" .. defaults.launchers.screenlocker, group = "launcher"}),
     -- screen capture program
    awful.key({}, "Print", function () -- for this bind to work, you must have an screenshot script in the path
        awful.spawn.easy_async_with_shell("screenshot", function () notifications.screenshot() end) end,
          {description = "runs maim screenshot", group = "launcher"}),

    -- scripts
    awful.key( { defaults.modkey }, ",", function () awful.util.spawn(defaults.scripts.f_launcher) end,
              {description = "runs f launcher", group = "scripts"}),
    awful.key( { defaults.modkey }, ".", function () awful.util.spawn(defaults.scripts.f_launcher_dired) end,
              {description = "dotfiles search", group = "scripts"}),
    awful.key( { defaults.modkey }, "t", function () awful.util.spawn(defaults.scripts.theme_changer) end,
              {description = "change the current theme", group = "scripts"}),

    -- audio manage
    awful.key({}, "XF86AudioLowerVolume", function ()
        awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%", false)
        notifications.show_volume() end),
    awful.key({}, "XF86AudioRaiseVolume", function ()
        awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%", false)
        notifications.show_volume() end),
    awful.key({}, "XF86AudioMute", function ()
        awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle", false)
        notifications.show_volume_mute() end),

    -- spotify shell
    awful.key( {}, "XF86AudioPlay", function () awful.util.spawn("sp play") end,
              {description = "play", group = "spotify"}),
    awful.key( {}, "XF86AudioPause", function () awful.util.spawn("sp play") end,
              {description = "pause", group = "spotify"}),
    awful.key( {}, "XF86AudioNext", function () awful.util.spawn("sp next") end,
              {description = "next song", group = "spotify"}),
    awful.key( {}, "XF86AudioPrev", function () awful.util.spawn("sp prev") end,
              {description = "previous song", group = "spotify"}),

    -- swapping screens function
    awful.key({ defaults.modkey }, "Tab",	function ()
    local focused_screen = awful.screen.focused()
    local s = focused_screen.get_next_in_direction(focused_screen, "right")
    if not s then
      s = focused_screen.get_next_in_direction(focused_screen, "left")
    end
    if not s then
      naughty.notify { preset = naughty.config.presets.critical, title = "could not get other screen" }
      return
    end
    focused_screen:swap(s)
    end,
    {description = "swap screens", group = "layout"})),

    -- menubar
    awful.key({ defaults.modkey }, "i", function() menubar.show() end,
      {description = "show the menubar", group = "launcher"}),

  -- client keybindings
  client = gears.table.join(
    awful.key({ defaults.modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ defaults.modkey }, "w", function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ defaults.modkey, "Control" }, "space",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({ defaults.modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ defaults.modkey, }, "o",      function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    awful.key({ defaults.modkey, }, "n",
        function (c)
            c.minimized = true
        end,
        {description = "minimize", group = "client"}),
    awful.key({ defaults.modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}),
    awful.key({ defaults.modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ defaults.modkey, "Shift" }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}))
}

  -- tags
for i = 1, 9 do
    bindings.keyboard.global = gears.table.join(bindings.keyboard.global,
        -- view tag only
        awful.key({ defaults.modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- move client to tag
        awful.key({ defaults.modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

-- module return
return bindings
