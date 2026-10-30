 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#0f131c',
    base01 = '#1b2029',
    base02 = '#262a33',
    base03 = '#8891a5',
    base04 = '#bec6dc',
    base05 = '#dfe2ef',
    base06 = '#dfe2ef',
    base07 = '#dfe2ef',
    base08 = '#ffb4ab',
    base09 = '#abc7ff',
    base0A = '#83d2e5',
    base0B = '#53d7f1',
    base0C = '#abc7ff',
    base0D = '#53d7f1',
    base0E = '#83d2e5',
    base0F = '#a6eeff',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#dfe2ef',          bg = '#0f131c' })
  hi('TelescopeBorder',         { fg = '#8891a5',             bg = '#0f131c' })
  hi('TelescopePromptNormal',   { fg = '#dfe2ef',          bg = '#0f131c' })
  hi('TelescopePromptBorder',   { fg = '#8891a5',             bg = '#0f131c' })
  hi('TelescopePromptPrefix',   { fg = '#53d7f1',             bg = '#0f131c' })
  hi('TelescopePromptCounter',  { fg = '#bec6dc',  bg = '#0f131c' })
  hi('TelescopePromptTitle',    { fg = '#0f131c',             bg = '#53d7f1' })
  hi('TelescopePreviewTitle',   { fg = '#0f131c',             bg = '#83d2e5' })
  hi('TelescopeResultsTitle',   { fg = '#0f131c',             bg = '#abc7ff' })
  hi('TelescopeSelection',      { fg = '#dfe2ef',          bg = '#262a33' })
  hi('TelescopeSelectionCaret', { fg = '#53d7f1',             bg = '#262a33' })
  hi('TelescopeMatching',       { fg = '#53d7f1',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#dfe2ef',          bg = '#0f131c' })
  hi('MiniPickBorder',         { fg = '#8891a5',             bg = '#0f131c' })
  hi('MiniPickPrompt',   { fg = '#dfe2ef',          bg = '#0f131c' })
  hi('MiniPickPromptPrefix',   { fg = '#53d7f1',             bg = '#0f131c' })
  hi('MiniPickBorderText',    { fg = '#0f131c',             bg = '#53d7f1' })
  hi('MiniPickMatchCurrent',      { fg = '#dfe2ef',          bg = '#262a33' })
  hi('MiniPickPromptCaret', { fg = '#53d7f1',             bg = '#262a33' })
  hi('MiniPickMatchRanges',       { fg = '#53d7f1',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
