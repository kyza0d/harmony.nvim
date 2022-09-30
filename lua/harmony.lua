local harmony = {}

local utils = require("harmony.utils")
local factory = require("harmony.factory")

local lighten = factory.change_hex_lightness

local defaults = require("harmony.defaults")

harmony.colors = setmetatable({}, {
  __index = function(_, key)
    return key
  end,
})

function harmony.setup(config)
  local global = vim.tbl_deep_extend("force", {}, defaults["*"], config["*"])

  local colorscheme = vim.tbl_deep_extend("force", {}, global, config[vim.g.colors_name] or global)
  -- print(vim.inspect(colorscheme.background))

  local variant = utils.get_variant() -- "1" or "2"

  local highlights = colorscheme.highlights

  local colors = setmetatable({}, {
    __index = function(_, key)
      local color = colorscheme[key]
      -- print(vim.inspect(colorscheme))
      local background = colorscheme.background[variant] or colorscheme.background
      local foreground = colorscheme.foreground[variant] or colorscheme.foreground

      -- If the colorscheme lookup isn't found
      if color then
        return color[variant] or color
      else
        -- Return fallback highlights
        -- colorscheme = global

        local shades = function()
          return {
            background_1 = lighten(background, 10),
            background_2 = lighten(background, 15),
            background_3 = lighten(background, 30),
            foreground_1 = lighten(foreground, -10),
            foreground_2 = lighten(foreground, -15),
            foreground_3 = lighten(foreground, -30),
          }
        end

        if highlights[key] then
          return highlights[key][variant] or highlights[key]
        else
          return shades()[key]
        end
      end
    end,
  })

  for group, gui in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, {
      fg = colors[gui.fg] or gui.fg,
      bg = colors[gui.bg] or gui.bg,
      sp = colors[gui.sp] or gui.sp,
      blend = gui.blend,
      bold = gui.bold,
      standout = gui.standout,
      underline = gui.underline,
      undercurl = gui.undercurl,
      underdouble = gui.underdouble,
      underdotted = gui.underdotted,
      strikethrough = gui.strikethrough,
      italic = gui.italic,
      reverse = gui.reverse,
      nocombine = gui.nocombine,
      link = gui.link,
      cterm = gui.cterm,
      ctermfg = gui.ctermfg,
      ctermbg = gui.ctermbg,
      default = gui.default,
    })
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
  -- harmony.theme = vim.tbl_deep_extend("force", {}, harmony.theme, themes or {})
end

return harmony
