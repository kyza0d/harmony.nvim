local harmony = {}

harmony.themes = {}

harmony.colors = {}

-- TODO: Add ability for plugins to register highlights

-- TODO: Add ability for plugins to register themes

-- stylua: ignore
harmony.colors = setmetatable({}, {
  __index = function(_, key)
    return key
  end,
})

local defaults = require("harmony.defaults")

function harmony.setup(themes)
  harmony.themes = vim.tbl_deep_extend("force", {}, harmony.themes, themes or {})

  local global = harmony.themes["*"] or defaults["*"]
  harmony.colorscheme = harmony.themes[vim.g.colors_name] or global

  local highlights = harmony.colorscheme.highlights

  local colors = setmetatable({}, {
    __index = function(_, key)
      return harmony.colorscheme[key]
    end,
  })

  -- stylua: ignore
  for group, gui in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, {
      fg            = colors[gui.fg],
      bg            = colors[gui.bg],
      sp            = colors[gui.sp],
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
      default       = gui.default,
      ctermfg       = gui.ctermfg,
      ctermbg       = gui.ctermbg,
      cterm         = gui.cterm,
    })
  end

  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    callback = function()
      harmony.setup(themes)
    end,
  })
end

-- @param themes table: themes, highlights
function harmony.register(themes)
  harmony.themes = vim.tbl_deep_extend("force", {}, harmony.themes, themes or {})
end

-- local Table = {}
-- Table.Var = "Testing"
--
-- function Table:Test()
--   print(self.Var)
-- end
--
-- Table:Test()

return harmony
