hammerSpoonEmoji = "🔨🥄"

hs.printf("======== config file reloaded ========")
hs.alert.show(hammerSpoonEmoji .. " Config Loaded")

animationDuration = 0

-- window sizing
hs.hotkey.bind({"cmd", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd","ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "ctrl"}, "f", function()
  -- size focused window to size of desktop
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)


hs.hotkey.bind({"cmd", "ctrl"}, "up", function()
  -- size focused window to top half of display
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "ctrl"}, "down", function()
  -- size focused window to bottom half of display
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- quick reload
hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
  hs.reload()
end)

-- stolen from @mrled
appCuts = {
  e = 'Emacs',
  d = 'Dash',
  h = 'Hammerspoon',
  f = 'Firefox',
  l = 'Slack',
  o = 'Microsoft Outlook',
  p = 'Bitwarden',
  r = 'Element',
  s = 'Safari',
  t = 'iTerm',
  c = 'Google Chrome',
  z = 'Zoom.us'  
}

modalHotKey = dofile(os.getenv("HOME") .. "/.config/hammerspoon/modalHotKey.lua")
appActionTable = {}
for key, app in pairs(appCuts) do
   appActionTable[key] = function() hs.application.launchOrFocus(app) end
end
appModal = modalHotKey.new(
  hs.hotkey.modal.new({"cmd", "ctrl"}, "Space"),
  appActionTable,
  appCuts,
  hammerSpoonEmoji .. "Awful App Switcher"
)

-- stolen from stackoverflow, for moving between monitors.
-- Get the focused window, its window frame dimensions, its screen frame dimensions,
-- and the next screen's frame dimensions.
-- https://stackoverflow.com/questions/54151343/how-to-move-an-application-between-monitors-in-hammerspoon
hs.hotkey.bind({"cmd", "ctrl"}, "o", function()
      local focusedWindow = hs.window.focusedWindow()
      local focusedScreenFrame = focusedWindow:screen():frame()
      local nextScreenFrame = focusedWindow:screen():next():frame()
      local windowFrame = focusedWindow:frame()

      -- Calculate the coordinates of the window frame in the next screen and retain aspect ratio
      windowFrame.x = ((((windowFrame.x - focusedScreenFrame.x) / focusedScreenFrame.w) * nextScreenFrame.w) + nextScreenFrame.x)
      windowFrame.y = ((((windowFrame.y - focusedScreenFrame.y) / focusedScreenFrame.h) * nextScreenFrame.h) + nextScreenFrame.y)
      windowFrame.h = ((windowFrame.h / focusedScreenFrame.h) * nextScreenFrame.h)
      windowFrame.w = ((windowFrame.w / focusedScreenFrame.w) * nextScreenFrame.w)

      -- Set the focused window's new frame dimensions
      focusedWindow:setFrame(windowFrame)
end)
