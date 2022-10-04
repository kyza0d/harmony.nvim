local defaults = {}

local colors = require("harmony.colors")

local highlights = {
  Pmenu = { bg = colors.background_1, fg = "foreground_0" },
}

-- stylua: ignore
defaults.themes = {
  ["*"] = {
    variant = "auto",

    background = { "#111111", "#ffffff" },
    foreground = { "#ffffff", "#111111" },
    red = { "#E86671", "#E86671" },
    green = { "#A9DC76", "#A9DC76" },
    yellow = { "#E7C547", "#E7C547" },
    blue = { "#7AA2F7", "#7AA2F7" },
    purple = { "#C594C5", "#C594C5" },
    accent = { "#7AA2F7", "#7AA2F7" },

    lightness = 0,

    plugins = {
      -- "nvim-telescope/telescope.nvim",
      -- "neovim/nvim-lspconfig",
      "akinsho/bufferline.nvim",
      "hrsh7th/nvim-cmp",
      "SmiteshP/nvim-navic",
      "folke/todo-comments.nvim",
      "lukas-reineke/indent-blankline.nvim"
    },

    highlights = {

      -- see :help highlight-groups
      ColorColumn = { bg = colors.background_1 },                                -- Used for the columns set with 'colorcolumn'. Conceal  Placeholder characters substituted for concealed text (see 'conceallevel').
      CurSearch = { bg = colors.background_3 },                                  -- Used for highlighting a search pattern under the cursor (see 'hlsearch').
      CursorColumn = { bg = colors.background_1 },                               -- Screen-column at the cursor, when 'cursorcolumn' is set.
      CursorLine = { bg = colors.background_1 },                                 -- Screen-line at the cursor, when 'cursorline' is set. Low if foreground (ctermfg OR guifg) is not set.
      Directory = { fg = colors.accent },                                        -- Directory names (and other special names in listings).
      DiffAdd = { bg = colors.green },                                           -- Diff mode: Added line.
      DiffChange = { bg = colors.blue },                                         -- Diff mode: Changed line.
      DiffDelete = { bg = colors.red },                                          -- Diff mode: Deleted line.
      DiffText = { bg = colors.background_1 },                                   -- Diff mode: Changed text within a changed line. diff.txt
      EndOfBuffer = { bg = colors.background_0 },                                -- Filler lines (~) after the end of the buffer. By default, this is highlighted like hl-NonText.
      ErrorMsg = { fg = colors.red },                                            -- Error messages on the command line.
      WinSeparator = { fg = colors.foreground_4 },                               -- Separators between window splits.
      Folded = { bg = colors.background_1 },                                     -- Line used for closed folds.
      FoldColumn = { fg = colors.foreground_3, bg = colors.background_0 },       -- 'foldcolumn' SignColumn Column where signs are displayed.
      SignColumn = { bg = colors.background_0 },                                 -- Column where signs are displayed.
      Substitute = { bg = colors.accent },                                       -- :substitute replacement text highlighting.
      LineNr = { fg = colors.foreground_4 },                                     -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
      CursorLineNr = { bg = colors.background_1 },                               -- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
      CursorLineSign = { bg = colors.background_1 },                             -- Like SignColumn when 'cursorline' is set for the cursor line.
      CursorLineFold = { bg = colors.background_1 },                             -- Like FoldColumn when 'cursorline' is set for the cursor line.
      MatchParen = { bg = colors.background_2 },                                 -- Character under the cursor or just before it, if it is a paired bracket, and its match. pi_paren.txt
      ModeMsg = { fg = colors.accent },                                          -- 'showmode' message (e.g., "-- INSERT --").
      MsgArea = { fg = colors.foreground_2 },                                    -- Area for messages and cmdline.
      MoreMsg = { fg = colors.accent },                                          -- more-prompt
      NonText = { fg = colors.accent },                                          -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also hl-EndOfBuffer.
      Normal = { bg = colors.background_0, fg = colors.foreground_0 },           -- Normal text.
      NormalFloat = { bg = colors.background_2, fg = colors.foreground_1 },      -- Normal text in floating windows.
      NormalNC = { bg = colors.background_0 },                                   -- Normal text in non-current windows.
      Pmenu = { bg = colors.background_1 },                                      -- Popup menu: Normal item.
      PmenuSel = { bg = colors.background_2 },                                   -- Popup menu: Selected item.
      PmenuSbar = { bg = colors.background_2 },                                  -- Popup menu: Scrollbar.
      PmenuThumb = { bg = colors.background_3 },                                 -- Popup menu: Thumb of the scrollbar.
      Question = { fg = colors.yellow },                                         -- hit-enter prompt and yes/no questions.
      QuickFixLine = { bg = colors.background_2 },                               -- Current quickfix item in the quickfix window. Combined with hl-CursorLine when the cursor is there.
      Search = { bg = colors.background_2 },                                     -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out. SpecialKey Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. hl-Whitespace
      SpellBad = { undercurl = true, sp = colors.red },                          -- Word that is not recognized by the spellchecker. spell Combined with the highlighting used otherwise.
      SpellCap = { undercurl = true, sp = colors.blue },                         -- Word that should start with a capital. spell Combined with the highlighting used otherwise.
      SpellLocal = { undercurl = true, sp = colors.blue },                       -- Word that is recognized by the spellchecker as one that is used in another region. spell Combined with the highlighting used otherwise.
      SpellRare = { undercurl = true, sp = colors.purple },                      -- Word that is recognized by the spellchecker as one that is hardly ever used. spell
      StatusLine = { bg = colors.background_negative_2 },                        -- Status line of current window.
      StatusLineNC = { bg = colors.background_negative_1 },                      -- Status lines of not-current windows. Note If this is equal to "StatusLine", Vim will use "^^^" in the status line of the current window.
      TabLine = { bg = colors.background_negative_2 },                           -- Tab pages line, not active tab page label.
      TabLineFill = { bg = colors.background_1 },                                -- Tab pages line, where there are no labels.
      TabLineSel = { bg = colors.background_4 },                                 -- Tab pages line, active tab page label.
      Title = { fg = colors.yellow },                                            -- Titles for output from ":set all", ":autocmd" etc.
      Visual = { bg = colors.background_2 },                                     -- Visual mode selection.
      VisualNOS = { bg = colors.background_2 },                                  -- Visual mode selection when vim is "Not Owning the Selection".
      WarningMsg = { bg = colors.background_0, fg = colors.red },                -- Warning messages.
      Whitespace = { fg = colors.foreground_3 },                                 -- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
      WildMenu = { bg = colors.background_2, fg = colors.foreground_3 },         -- Current match in 'wildmenu' completion.
      WinBar = { bg = colors.background_0, fg = colors.foreground_3 },           -- Window bar of current window.
      WinBarNC = { bg = colors.background_0, fg = colors.foreground_3 },         -- Window bar of not-current current window.

      -- see :help diagnostic-highlights
      DiagnosticError = { fg = colors.red },                                     -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticWarn = { fg = colors.yellow },                                   -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticInfo = { fg = colors.purple },                                   -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticHint = { fg = colors.blue },                                     -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticVirtualTextError = { fg = colors.red },                          -- Used for "Error" diagnostic virtual text.
      DiagnosticVirtualTextWarn = { fg = colors.yellow },                        -- Used for "Warn" diagnostic virtual text.
      DiagnosticVirtualTextInfo = { fg = colors.purple },                        -- Used for "Info" diagnostic virtual text.
      DiagnosticVirtualTextHint = { fg = colors.blue },                          -- Used for "Hint" diagnostic virtual text.
      DiagnosticUnderlineError = { sp = colors.red, undercurl = true },          -- Used to underline "Error" diagnostics.
      DiagnosticUnderlineWarn = { sp = colors.yellow, undercurl = true },        -- Used to underline "Warn" diagnostics.
      DiagnosticUnderlineInfo = { sp = colors.purple, undercurl = true },        -- Used to underline "Info" diagnostics.
      DiagnosticUnderlineHint = { sp = colors.blue, undercurl = true },          -- Used to underline "Hint" diagnostics.
      DiagnosticFloatingError = { fg = colors.red, bg = colors.background_1 },   -- Used to color "Error" diagnostic messages in diagnostics float. See vim.diagnostic.open_float()
      DiagnosticFloatingWarn = { fg = colors.yellow, bg = colors.background_1 }, -- Used to color "Warn" diagnostic messages in diagnostics float.
      DiagnosticFloatingInfo = { fg = colors.purple, bg = colors.background_1 }, -- Used to color "Info" diagnostic messages in diagnostics float.
      DiagnosticFloatingHint = { fg = colors.blue, bg = colors.background_1 },   -- Used to color "Hint" diagnostic messages in diagnostics float.
      DiagnosticSignError = { fg = colors.red },                                 -- Used for "Error" signs in sign column.
      DiagnosticSignWarn = { fg = colors.yellow },                               -- Used for "Warn" signs in sign column.
      DiagnosticSignInfo = { fg = colors.purple },                               -- Used for "Info" signs in sign column.
      DiagnosticSignHint = { fg = colors.blue },                                 -- Used for "Hint" signs in sign column.
    },

    enable = false,
  },
}

return defaults
