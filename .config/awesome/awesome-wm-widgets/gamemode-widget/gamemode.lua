-------------------------------------------------
-- game mode button for Awesome Window Manager
-- changes x resolution

-- @author josiah ledbetter
-- @copyright do whatever the fuck you want
-------------------------------------------------

local wibox = require("wibox")
local watch = require("awful.widget.watch")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty       = require("naughty")
local gears = require("gears")


local XRANDR_GAME_RESOLUTION_COMMAND = "xrandr --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --primary --output DP-2 --mode 1920x1080 --right-of HDMI-0 --rotate left --output DP-4 --mode 1920x1080 --left-of HDMI-0 --rotate right --output DP-0 --off"

local XRANDR_NORMAL_RESOLUTION_COMMAND = "xrandr --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate normal --primary --output DP-2 --mode 1920x1080 --right-of HDMI-0 --rotate left --output DP-4 --mode 1920x1080 --left-of HDMI-0 --rotate right --output DP-0 --off"

local iconpath = "/home/josiah/.config/awesome/gamemode.png"

local toggle = 0

local demoMode_widget = wibox.widget {
  wibox.widget {
      image  = beautiful.gamemode_icon or iconpath,
      resize = true,
      widget = wibox.widget.imagebox
    },
    widget = wibox.container.background
}

watch(XSCREENSAVER_DEACTIVATE_COMMAND, XSCREENSAVER_TIMER, demoMode_widget)

function activate_game_mode()
  gears.timer {
    timeout   = XSCREENSAVER_TIMER,
    autostart = true,
    callback  = function()
        awful.util.spawn_with_shell(XRANDR_GAME_RESOLUTION_COMMAND)
        --naughty.notify{ 
         --title= "Notification status",
         --text = tostring(not naughty.is_suspended()),
         --ignore_suspend = true,
       --}
      end,
    single_shot = false,
}
end

demoMode_widget:buttons(awful.util.table.join(
                       awful.button({ }, 1, function () 
                         if toggle == 0 then
			    activate_game_mode()
			    toggle = 1
			    demoMode_widget.bg =  beautiful.fg_urgent
                         else
			    demoMode_widget.bg =  beautiful.bg_normal
			    awesome.restart()
			    toggle = 0
                         end
                         --naughty.notify{ 
                           --title= "Notification status",
                           --text = tostring(not naughty.is_suspended()),
                           --ignore_suspend = true,
                         --}
                     end)
                       ))


return demoMode_widget
