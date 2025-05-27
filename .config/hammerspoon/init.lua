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

-- stolen from @mrled
appCuts = {
    e = 'Omnifocus',
    d = 'Drafts',
    f = 'Firefox.app',
    h = 'Hammerspoon',
    l = "Mattermost.app",
    m = 'Mail.app',
    o = 'Fantastical.app',
    p = '1password.app',
    t = 'ghostty.app',
    z = 'Chrome.app',
    v = 'Zed',
    x = "xcode"
}

modalHotKey = dofile(os.getenv("HOME") .. "/.config/hammerspoon/modalHotKey.lua")
appActionTable = {}
for key, app in pairs(appCuts) do
    appActionTable[key] = function() hs.application.launchOrFocus(app) end
end
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

local GridCraft = require("GridCraft")
-- nested modal
local chatModal = GridCraft.modal(nil, nil, {
    {
        GridCraft.action { key = "s", appName = "Slack" },
        GridCraft.action { key = "m", appName = "Mattermost" },
        GridCraft.action { key = "d", appName = "Discord" },
    }
}, "Chat Apps")

local leader


leader = GridCraft.modal(
-- The hokey to invoke this is ctrl-shift-f11
    { "cmd", "ctrl", "alt", "shift" },
    "Space",
    -- Now we have a table of tables to represent the grid.
    -- (Lua has a data structure called "tables" which can array-like, as we have them here.
    -- They can also be associative key=value tables, but we don't need to know about those to configure GridCraft.)
    -- Our 3x3 grid has 3 rows, and aeach row has 3 keys
    {
        -- The table for the top row
        {
            -- Regular applications passed with appName pull the icon from the application
            GridCraft.action { key = "w", appName = "Terminal" },
            GridCraft.action { key = "e", appName = "ChatGPT" },
            -- Here's a more complicated action
            GridCraft.action {
                key = "r",
                -- You can make custom actions by passing any Lua function to the action parameter,
                -- even one you define yourself!
                -- Here we use one that is built in to Hammerspoon that will lock the screen.
                action = hs.caffeinate.lockScreen,
                actionDesc = "Lock screen",
                -- To use a Phosphor icon, pass the icon name and weight.
                -- Phosphor icons are automatically colored the same color as the description text.
                icon = GridCraft.iconPhosphor("lock", "regular")
            },
        },
        -- The table for the middle row
        {
            GridCraft.action { key = "s", appName = "1Password" },
            GridCraft.action { key = "d", appName = "OmniFocus" },
            GridCraft.action { key = "f", appName = "Finder" },
        },
        -- The table for the bottom row
        {
            GridCraft.action { key = "x", appName = "Firefox" },
            -- By default it displays the application name, override that with actionDesc
            GridCraft.action {
                key = "c",
                actionDesc = "Chat Apps",
                action = function()
                    leader:stop()
                    chatModal:start()
                end,
                icon = "<span>💬</span>",
            },
            GridCraft.action {
                key = "v",
                action = hs.reload,
                actionDesc = "hs.reload",
                -- The icon can be anything that returns a <svg> or <img> tag.
                -- This one is using a raw Phosphor icon to show how it works.
                -- (In lua, strings starting with [[ and ending with ]] can include single and double quotes,
                -- as well as newlines, so they are convenient for HTML/SVG elements.)
                icon = [[<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256"><rect width="256" height="256" fill="none"/><polyline points="184 104 232 104 232 56" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><path d="M188.4,192a88,88,0,1,1,1.83-126.23L232,104" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/></svg>]]
            },
        },
    },
    -- This a title that is just nice for logging in the Hammerspoon console.
    "GridKeys Example"
)

-- -- bind the top-level hotkey manually
-- hs.hotkey.bind({ "cmd", "ctrl" }, "space", function()
--     leader:start()
-- end)

-- escape from submodal back to leader
chatModal.triggerKey:bind({}, "escape", function()
    chatModal:stop()
    leader:start()
end)
