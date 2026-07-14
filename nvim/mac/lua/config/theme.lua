local M = {}

M.themes = { "flume", "kanagawa-dragon", "github_dark_dimmed" }
M.current = 2 -- kanagawa-dragon is the default on startup

function M.apply(name)
  vim.cmd.colorscheme(name)
end

function M.toggle()
  M.current = M.current % #M.themes + 1
  local name = M.themes[M.current]
  M.apply(name)
  vim.notify("Theme: " .. name, vim.log.levels.INFO)
end

return M
