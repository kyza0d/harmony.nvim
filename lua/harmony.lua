local harmony = {}

harmony.themes = {}

harmony.colors = {}

-- TODO: Add ability to create custom highlights

-- TODO: Add ability for plugins to register highlights

-- TODO: Add ability for plugins to register themes

harmony.colors = {
  background = "background",
  forground = "forground",
  blue = "blue",
  green = "green",
  purple = "purple",
  yellow = "yellow",
  red = "red",
  accent = "accent",
}

function harmony.setup(themes)
  harmony.themes = vim.tbl_deep_extend("force", {}, harmony.themes, themes or {})

  harmony.builtin = harmony.themes[vim.g.colors_name]

  local highlights = harmony.builtin.highlights

  local colors = setmetatable({}, {
    __index = function(_, key)
      return harmony.builtin[key]
    end,
  })

  for index, value in pairs(highlights) do
    vim.api.nvim_set_hl(0, index, { fg = colors[value.fg] })
  end
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
