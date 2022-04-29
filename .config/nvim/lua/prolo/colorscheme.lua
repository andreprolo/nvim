local colorscheme = "gruvbox"

local status_success, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_success then
  vim.notify("colorscheme " .. colorscheme .. " not found")
  return
end
