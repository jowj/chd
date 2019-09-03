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
  h = 'Hammerspoon',
  f = 'Firefox',
  l = 'Ripcord',
  o = 'Microsoft Outlook',
  p = '1Password 7',
  r = 'Riot',
  s = 'Safari',
  t = 'iTerm',
}

modalHotKey = dofile(os.getenv("HOME") .. "/.hammerspoon/modalHotKey.lua")
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
