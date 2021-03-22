require('nvim_comment').setup()

vim.api.nvim_set_keymap("n", "<C-b>", ":CommentToggle<CR>", {noremap=true, silent=true})
vim.api.nvim_set_keymap("v", "<C-b>", ":CommentToggle<CR>", {noremap=true, silent=true})
