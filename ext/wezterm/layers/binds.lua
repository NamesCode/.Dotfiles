local M = {}

M.apply = function(config, wez)
    config.keys = {
        {
            key = "f",
            mods = "SHIFT|CTRL",
            action = wez.action.ToggleFullScreen,
        },
        {
            key = "?",
            mods = "SHIFT|CTRL",
            action = wez.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },
        {
            key = "_",
            mods = "SHIFT|CTRL",
            action = wez.action.SplitVertical({ domain = "CurrentPaneDomain" }),
        },
        {
            key = "w",
            mods = "SHIFT|CTRL",
            action = wez.action.PaneSelect,
        },
        {
            key = "p",
            mods = "SHIFT|CTRL",
            action = wez.action.ActivateCommandPalette,
        }
    }
    config.mouse_bindings = {
        -- only select with lmb, don't open links
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "NONE",
            action = wez.action.CompleteSelection("PrimarySelection"),
        },

        -- ctrl+lmb for links
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = wez.action.OpenLinkAtMouseCursor,
        },
    }
end

return M
