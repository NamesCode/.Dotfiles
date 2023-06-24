local wez = require("wezterm")

local config = {}
if wez.config_builder then
	config = wez.config_builder()
end

local layers = { "aesthetics", "binds", "windows" }

for _, layer in ipairs(layers) do
	local ok, layer_config = pcall(require, "layers." .. layer)
	if ok then
		layer_config.apply(config, wez)
	end
end

return config
