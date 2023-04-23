-- TODO: Provide callback to colors using `require("harmony").colors`

local utils = require("harmony.utils")
local factory = require("harmony.factory")
local defaults = require("harmony.defaults")

local harmony = {}

-- @class colors <table,tabl> Default value of the string passed as key in case of an undefined key request.
harmony.colors = setmetatable({}, {
  __index = function(_, key)
    return key
  end,
})

function harmony.setup(config)
  -- @param config <table, table> The configuration to merge with the default themes
  harmony.themes = utils.extend("force", defaults.themes, config or defaults.themes)

  -- @class table <table, string> Color config for current colorscheme
  local colorscheme = utils.extend("force", harmony.themes["*"], harmony.themes[vim.g.colors_name] or {})

  -- @class highlights <table, table> Custom highlights
  colorscheme.highlights = colorscheme.highlights or {}

  local plugin_highlights = require("harmony.plugins")

  -- @param colorscheme <table, string> The colorscheme table
  -- @param plugin_highlights <table, string> Highlights for supported plugins
  for _, plugin in ipairs(colorscheme.plugins or {}) do
    if plugin_highlights[plugin] then
      colorscheme.highlights = utils.extend("keep", colorscheme.highlights, plugin_highlights[plugin])
    end
  end

  -- @class variant <number> The color variant, either 1 (dark) or 2 (light)
  local variant = utils.get_variant()

  -- @param value The value to resolve the color variant for.
  -- @return The resolved color variant.
  local function resolve_color_variant(value)
    return type(value) == "table" and value[variant] or value
  end

  -- @class string: Returns respective value if found in `lookup`
  local colors = setmetatable({}, {
    __index = function(_, key)
      if colorscheme[key] then
        -- @class lookup: Reference the color values for the given scheme
        return resolve_color_variant(colorscheme[key])
      end

      local bg = resolve_color_variant(colorscheme.bg)
      local fg = resolve_color_variant(colorscheme.fg)

      local shades = {}

      -- @class shades: Lightness (0-4)
      if variant == 1 then
        shades = {
          bg_0 = bg,
          bg_1 = factory.lightness(bg, 6),
          bg_2 = factory.lightness(bg, 14),
          bg_3 = factory.lightness(bg, 16),
          bg_4 = factory.lightness(bg, 23),

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
      else
        -- light variant
        shades = {
          bg_0 = bg,
          bg_1 = factory.lightness(bg, -6),
          bg_2 = factory.lightness(bg, -14),
          bg_3 = factory.lightness(bg, -18),
          bg_4 = factory.lightness(bg, -25),

          bg_negative_1 = factory.lightness(bg, -8),
          bg_negative_2 = factory.lightness(bg, -15),

          fg_0 = fg,
          fg_1 = factory.lightness(fg, 20),
          fg_2 = factory.lightness(fg, 30),
          fg_3 = factory.lightness(fg, 60),
          fg_4 = factory.lightness(fg, 120),

          fg_negative_1 = factory.lightness(fg, -3),
          fg_negative_2 = factory.lightness(fg, -4),
        }
      end

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
    local attrs = {}

    for _, key in ipairs(keys) do
      attrs[key] = colors[gui[key]] or gui[key]
    end

    if gui.link then
      attrs.link = gui.link
    end

    if gui.clear then
      vim.api.nvim_cmd({ cmd = "highlight", args = { "clear", group } }, {})
    end

    local success, error = pcall(vim.api.nvim_set_hl, 0, group, attrs)

    if not success then
      -- Log the error for debugging purposes
      print("harmony.nvim: Error setting highlight group '" .. group .. "': " .. error)
      return
    end
  end

  local harmony_augroup = vim.api.nvim_create_augroup("harmony.nvim", { clear = true })

  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    callback = function()
      harmony.setup(config)
    end,
    group = harmony_augroup,
  })

  vim.api.nvim_create_autocmd({ "ColorSchemePre" }, {
    callback = function()
      vim.api.nvim_cmd({ cmd = "highlight", args = { "clear" } }, {})
    end,
    group = harmony_augroup,
  })
end

function harmony.register(themes)
  harmony.themes = utils.extend("keep", harmony.themes, themes)
  harmony.setup(harmony.themes)
end

return harmony
