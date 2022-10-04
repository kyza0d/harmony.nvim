local harmony = {}

local utils = require("harmony.utils")
local factory = require("harmony.factory")

local lightness = factory.change_hex_lightness

local defaults = require("harmony.defaults")

-- TODO: Figure out how to return color values
harmony.colors = setmetatable({}, {
  __index = function(_, key)
    return key
  end,
})

local plugin_highlights = require("harmony.plugins")

harmony.themes = {}

function harmony.setup(config)
  local global = vim.tbl_deep_extend("force", {}, defaults.themes, config)

  local variant = utils.get_variant() -- 1 or 2

  harmony.themes = vim.tbl_deep_extend("force", {}, global, config or global)

  -- merge defaults with user config
  local colorscheme = vim.tbl_deep_extend("force", {}, harmony.themes["*"], harmony.themes[vim.g.colors_name] or {})

  local highlights = colorscheme.highlights
  local plugins = colorscheme.plugins

  -- add plugin highlights
  for _, plugin in ipairs(plugins) do
    if plugin_highlights[plugin] then
      highlights = vim.tbl_deep_extend("force", {}, highlights, plugin_highlights[plugin])
    end
  end

  local colors = setmetatable({}, {
    __index = function(_, key)
      local lookup = colorscheme[key]
      local background = colorscheme.background[variant] or colorscheme.background
      local foreground = colorscheme.foreground[variant] or colorscheme.foreground

      -- If the colorscheme lookup isn't found
      if lookup then
        return lookup[variant] or lookup
      else
        local shades = {
          background_0 = background,
          background_1 = lightness(background, 4),
          background_2 = lightness(background, 8),
          background_3 = lightness(background, 10),
          background_4 = lightness(background, 14),
          background_negative_1 = lightness(background, -4),
          background_negative_2 = lightness(background, -6),

          foreground_0 = foreground,
          foreground_1 = lightness(foreground, -10),
          foreground_2 = lightness(foreground, -15),
          foreground_3 = lightness(foreground, -35),
          foreground_4 = lightness(foreground, -45),
          foreground_negative_1 = lightness(foreground, 3),
          foreground_negative_2 = lightness(foreground, 5),
        }

        if highlights[key] then
          return highlights[key][variant] or highlights[key]
        else
          return shades[key]
        end
      end
    end,
  })

  -- stylua: ignore
  for group, gui in pairs(highlights) do
    if gui.links then
      vim.api.nvim_command("highlight! link " .. group .. " " .. gui.links)
    else
      vim.api.nvim_set_hl(0, group, {
        fg            = colors[gui.fg] or gui.fg,
        bg            = colors[gui.bg] or gui.bg,
        sp            = colors[gui.sp] or gui.sp,
        blend         = gui.blend,
        bold          = gui.bold,
        standout      = gui.standout,
        underline     = gui.underline,
        undercurl     = gui.undercurl,
        underdouble   = gui.underdouble,
        underdotted   = gui.underdotted,
        strikethrough = gui.strikethrough,
        italic        = gui.italic,
        reverse       = gui.reverse,
        nocombine     = gui.nocombine,
        link          = gui.link,
        cterm         = gui.cterm,
        ctermfg       = gui.ctermfg,
        ctermbg       = gui.ctermbg,
        default       = gui.default,
      })
    end
  end

  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    callback = function()
      harmony.setup(config)
    end,
    group = vim.api.nvim_create_augroup("harmony.nvim", {
      clear = true,
    }),
  })
end

function harmony.register(themes)
  harmony.themes = vim.tbl_deep_extend("force", {}, harmony.themes, themes)
  harmony.setup(harmony.themes)
end

return harmony
