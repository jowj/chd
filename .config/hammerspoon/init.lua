hammerSpoonEmoji = "🔨🥄"

hs.printf("======== config file reloaded ========")
hs.alert.show(hammerSpoonEmoji .. " Config Loaded")

animationDuration = 0

-- window sizing
hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "Left", function()
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

hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "Right", function()
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

hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "f", function()
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


hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "up", function()
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

hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "down", function()
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
hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "R", function()
    hs.reload()
end)

-- appModal = modalHotKey.new(
--     hs.hotkey.modal.new({ "cmd", "ctrl", "alt", "shift" }, "Space"),
--     appActionTable,
--     appCuts,
--     hammerSpoonEmoji .. "Awful App Switcher"
-- )

-- stolen from stackoverflow, for moving between monitors.
-- Get the focused window, its window frame dimensions, its screen frame dimensions,
-- and the next screen's frame dimensions.
-- https://stackoverflow.com/questions/54151343/how-to-move-an-application-between-monitors-in-hammerspoon
hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "o", function()
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

-- The "@diagnostic" and "spoon = spoon" lines tell VS Code's Lua extension
-- that 'spoon' is a global variable injected before running this code.
-- You don't need them in your Hammerspoon config (but they won't hurt).
---@diagnostic disable-next-line: undefined-global, lowercase-global
spoon = spoon or {}

-- Load the GridCraft spoon
hs.loadSpoon("GridCraft")

local chatSubmenu = {
    {
        spoon.GridCraft.action { key = "a", application = "Messages" },
        spoon.GridCraft.action { key = "s", application = "Slack" },
        spoon.GridCraft.action { key = "d", application = "Discord" },
        spoon.GridCraft.action { key = "f", application = "Mattermost" },
        spoon.GridCraft.action { key = "g", application = "Signal" },
    },
}


local primaryMenu = {
    {
        spoon.GridCraft.action { key = "w", application = "Fantastical" },
        spoon.GridCraft.action { key = "e", application = "Omnifocus" },
        spoon.GridCraft.action { key = "r", application = "Finder" },
        spoon.GridCraft.action { key = "t", application = "Ghostty" },
    },
    {
        spoon.GridCraft.action { key = "s", application = "1password.app" },
        spoon.GridCraft.action { key = "d", application = "Drafts" },
        spoon.GridCraft.action { key = "f", application = "Firefox" },
        spoon.GridCraft.action { key = "g", application = "Chatgpt" },
    },
    {
        -- spoon.GridCraft.action { key = "z", application = "Chrome" },
        spoon.GridCraft.action { key = "x", application = "xcode" },
        spoon.GridCraft.action {
            key = "c",
            submenu = chatSubmenu,
            description = "coms",
            icon = spoon.GridCraft.iconPhosphor("chats", "regular")
        },
        spoon.GridCraft.action { key = "v", application = "Zed" },
        spoon.GridCraft.action { key = "b", application = "Bear" },
    }
}

spoon.GridCraft.grid(
-- The hokey to invoke this is ctrl-shift-f11
    { "cmd", "ctrl", "alt", "shift" },
    "Space",
    -- The table of tables for the hotkey grid, defined above
    primaryMenu,
    -- This a title that is just nice for logging in the Hammerspoon console.
    "Awful Grid"
)
