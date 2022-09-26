local harmony = {}

harmony._themes = {}

-- TODO: Add ability to create custom highlights

-- TODO: Add ability for plugins to register highlights

-- TODO: Add ability for plugins to register themes

-- @param themes table: themes, highlights
function harmony.themes(theme)
  harmony._themes = vim.tbl_deep_extend("force", {}, harmony._themes, theme or {})
end

function harmony:get_highlights()
  if not harmony._themes[vim.g.colors_name] then
    return
  end
  return harmony._themes[vim.g.colors_name].highlights
end

function harmony:set_highlights(options)
  local defaults = require("harmony.defaults")
  options = vim.tbl_deep_extend("force", {}, defaults, options or {})

  local highlights = harmony:get_highlights()
  print(vim.inspect(highlights))
end

function harmony.setup(options)
  local options = options or {}
  local group = vim.api.nvim_create_augroup("UpdateSetup", { clear = true })

  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      harmony:set_highlights(options)
    end,
    group = group,
  })
end

-- @param themes table: themes, highlights
function harmony.register(themes)
  harmony._themes = vim.tbl_deep_extend("force", {}, harmony._themes, themes or {})
end

return harmony
