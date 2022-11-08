local keymap = require("prolo.keymap")

local nnoremap = keymap.nnoremap
local inoremap = keymap.inoremap

nnoremap("<leader>e", ":Ex<CR>")
inoremap("jk", '<C-\\><C-n>')

-- Telescope
local telescope = require("telescope.builtin")
nnoremap("<leader>f", telescope.find_files)
nnoremap("<leader>F", telescope.live_grep)

