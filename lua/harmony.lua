local harmony = {}

harmony.themes = {}

local factory = require("harmony.factory")
local utils = require("harmony.utils")
local defaults = require("harmony.defaults")
local plugin_highlights = require("harmony.plugins")

local api = vim.api

harmony.colors = setmetatable({}, {
  __index = function(_, key)
    return key
  end,
})

function harmony.setup(config)
  --- Merges `config` with the default values
  -- @param config The configuration to merge with the default themes
  -- @return A table containing the merged default themes and configuration
  harmony.themes = utils.extend("force", defaults.themes, config or defaults.themes)

  --- Merges the global and local color scheme, with the local color scheme taking precedence
  -- @return The resulting merged color scheme
  local colorscheme = utils.extend("force", harmony.themes["*"], harmony.themes[vim.g.colors_name] or {})

  --- Initializes the colorscheme.highlights table if it does not exist
  colorscheme.highlights = colorscheme.highlights or {}

  --- Merges the highlights from plugins specified in the colorscheme into the colorscheme highlights
  -- @param colorscheme The colorscheme table
  -- @param plugin_highlights A table containing the highlights for different plugins
  for _, plugin in ipairs(colorscheme.plugins or {}) do
    if plugin_highlights[plugin] then
      colorscheme.highlights = utils.extend("keep", colorscheme.highlights, plugin_highlights[plugin])
    end
  end

  --- Gets the color variant from `vim.opt.background._value`
  -- @return The color variant, either 1 (dark) or 2 (light)
  local variant = utils.get_variant()

  --- Resolves a color variant based on the provided value.
  -- If the `value` is a table, it returns either `value[variant]` or `value.default`, whichever is available.
  -- @param value The value to resolve the color variant for.
  -- @return The resolved color variant.
  local function resolve_color_variant(value)
    return type(value) == "table" and (value[variant] or value.default) or value
  end

  local colors = setmetatable({}, {
    __index = function(_, key)
      local lookup = colorscheme[key]

      local bg = resolve_color_variant(colorscheme.bg)
      local fg = resolve_color_variant(colorscheme.fg)

      if lookup then
        return resolve_color_variant(lookup)
      end

      if colorscheme.highlights[key] then
        return resolve_color_variant(colorscheme.highlights[key])
      end

      local shades = {
        bg_0 = bg,
        bg_1 = factory.lightness(bg, 6),
        bg_2 = factory.lightness(bg, 14),
        bg_3 = factory.lightness(bg, 18),
        bg_4 = factory.lightness(bg, 25),

        bg_negative_1 = factory.lightness(bg, -8),
        bg_negative_2 = factory.lightness(bg, -15),
        fg_0 = fg,
        fg_1 = factory.lightness(fg, -20),
        fg_2 = factory.lightness(fg, -30),
        fg_3 = factory.lightness(fg, -60),
        fg_4 = factory.lightness(fg, -120),

        fg_negative_1 = factory.lightness(fg, 3),
        fg_negative_2 = factory.lightness(fg, 4),
      }

      return shades[key]
    end,
  })

  -- stylua: ignore
  local keys = {
    "fg", "bg", "sp", "blend", "bold", "standout", "underline",
    "undercurl", "underdouble", "underdotted", "strikethrough", "italic", "reverse",
    "nocombine",  "cterm", "ctermfg", "ctermbg", "default"
  }

  for group, gui in pairs(colorscheme.highlights) do
    if gui.link then
      api.nvim_set_hl(0, group, { link = gui.link })
    else
      local attrs = {}
      for _, key in ipairs(keys) do
        attrs[key] = colors[gui[key]] or gui[key]
      end

      local success, error = pcall(api.nvim_set_hl, 0, group, attrs)

      if not success then
        -- Log the error for debugging purposes
        print("Error setting highlight group '" .. group .. "': " .. error)
        return
      end
    end

    if gui.clear then
      api.nvim_cmd({ cmd = "highlight", args = { "clear", group } }, {})
    end
  end

  local harmony_augroup = api.nvim_create_augroup("harmony.nvim", { clear = true })

  api.nvim_create_autocmd({ "ColorScheme" }, {
    callback = function()
      harmony.setup(config)
    end,
    group = harmony_augroup,
  })
end

function harmony.register(themes)
  harmony.themes = utils.extend("keep", harmony.themes, themes)
  harmony.setup(harmony.themes)
end

return harmony
