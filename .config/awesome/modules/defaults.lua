-- modules/defaults.lua
-- variables used in the rest of modules

local awful = require("awful")
local wibox = require("wibox")

local defaults = {
    theme = "reborn",
    modkey = "Mod4",
    paths = {},  -- paths are declared at the bottom of this module
    scripts =
        {   -- scripts have to be located in a directory present on the PATH
            dotf = "dotf",
            f_launcher = "f_launcher",
            f_launcher_dired = "f_launcher_dired",
            theme_changer = "select_theme",
        },
    launchers =
        {   -- default programs
            terminal = "alacritty",
            editor = os.getenv("VISUAL"),  -- VISUAL: emacs on graphical mode
            program_launcher = "rofi",
            navigator = "brave",
            navigator_private = "brave --incognito",
            email_client = "thunderbird",
            hypervisor = "virt-manager",
            file_manager = "pcmanfm",
            password_manager = "keepassxc",
            sound_manager = "pavucontrol",
            discord = "discord",
            screenlocker = "betterlockscreen -l -q",
            vbox = "virtualbox -style Kvantum",
            rofi_theme = os.getenv("ROFI_THEME"),
            conky = "conky -c " .. os.getenv("HOME") .. "/.conkyrc",
        },
    widgets =
        {   -- one-line widgets (rest of widgets located at widgets dir)
            spacer_small = wibox.widget({ forced_width = 5, layout = wibox.layout.fixed.horizontal }),
            spacer = wibox.widget({ forced_width = 15, layout = wibox.layout.fixed.horizontal }),
            separator = wibox.widget.separator{ orientation = "vertical", forced_width = 1},
        },
}

-- paths
defaults.paths.home = os.getenv("HOME")
defaults.paths.config = awful.util.getdir("config")
defaults.paths.theme_dir = defaults.paths.config .. "themes/" .. defaults.theme
defaults.paths.theme = defaults.paths.theme_dir.. "/theme.lua"
defaults.paths.screenshots = defaults.paths.home .. "/pics/prt"
defaults.paths.wall = defaults.paths.theme_dir .. "/wall/wall.png"

return defaults
