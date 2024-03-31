-- themes/offwhite
-- a theme with a plain wallpaper and mostly gray colors
-- and white bone as empashis color

-- import of libraries
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local defaults = require("modules.defaults")

-- module declaration & icons path
local icons_path = defaults.paths.theme_dir .. '/icons'
local theme = {}

-- font & wallpaper
theme.font = "Mononoki Nerd Font Bold 9"

-- main colors
theme.fg_normal  = "#ffffdd"
theme.bg_normal  = "#1f2025"
theme.underline_color = theme.fg_normal
theme.fg_focus   = theme.fg_normal
theme.fg_urgent  = theme.fg_normal
theme.bg_focus   = theme.bg_normal
theme.bg_urgent  = theme.bg_normal

-- tasklist and systray colors
theme.tasklist_bg_focus = theme.bg_normal
theme.tasklist_fg_focus = theme.fg_normal
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = 15
theme.tags = { ":WWW ", "/DEV ", "(EMS) ", "&VSH ", "$SND ", "{SYS} ", "!THRD " }

-- programs notifications
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_border_color = theme.bg_normal
theme.notification_width = 550
theme.notification_height = 100
theme.notification_border_width = 10
theme.notification_position = "top_middle"
theme.notification_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 4)
end

-- sound notifications
theme.vol_up_icon = icons_path .. '/vol.png'
theme.vol_down_icon = icons_path .. '/vol_low.png'
theme.vol_mute_icon = icons_path .. '/vol_mute.png'

-- menu
theme.menu_fg_normal = theme.underline_color
theme.menu_fg_focus = theme.bg_normal
theme.menu_bg_normal = theme.bg_normal
theme.menu_bg_focus = theme.underline_color

-- hotkeys menu and menu
theme.hotkeys_bg = theme.bg_normal
theme.hotkeys_fg = theme.fg_normal
theme.hotkeys_font = "Mononoki Nerd Font 10"
theme.hotkeys_modifiers_fg = theme.notification_fg
theme.hotkeys_border_color = theme.fg_normal

-- borders and gap
theme.useless_gap   = dpi(8)
theme.border_width  = dpi(0)
theme.border_normal = "#24273A"
theme.border_focus  = "#121915"
theme.border_marked = "#CC939395"

-- titlebars
theme.titlebar_bg_focus  = "#24273A95" 
theme.titlebar_bg_normal = "#24273A95" 

-- mouse finder
theme.mouse_finder_color = "#CC9393"

-- menu settings
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- taglist icon
theme.taglist_squares_unsel = icons_path .. "/square_b.png"

-- nrk icon
theme.nrk_icon = icons_path .. "/nrk.png"

-- awesome and menu icons
theme.awesome_icon           = icons_path .. "/awesome_icon.png"
theme.menu_submenu_icon      = icons_path .. "/submenu.png"

-- spotify widget
theme.play_icon = icons_path .. "/note_on.png"
theme.pause_icon = icons_path .. "/note.png"

-- layout icons
theme.layout_tile       = icons_path .. "/tile.png"
theme.layout_tilebottom = icons_path .. "/tilebottom.png"
theme.layout_floating   = icons_path .. "/floating.png"

-- module return
return theme
