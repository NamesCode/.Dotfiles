local M = {}

M.apply = function(config, wez)
    if not string.match(wez.target_triple, "windows") then
        return
    end

    config.default_prog = { "powershell.exe" }
    config.default_domain = "WSL:Ubuntu"
end

return M
