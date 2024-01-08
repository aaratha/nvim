-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>oo", ":e ~/OneDrive/org/notes.org<CR>", { desc = "Open Notes.org" })
vim.keymap.set("n", "<leader>oz", ":ZenMode<CR>", { desc = "Zen Mode" })
vim.keymap.set("n", "<leader>cc", "ggVG:ChatGPTEditWithInstructions<CR>", { desc = "ChatGPT Edit With Instructions" })
vim.keymap.set("n", "<leader>cv", ":ChatGPT<CR>", { desc = "ChatGPT" })
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>t<leader>", ":terminal<CR>", { desc = "Open Terminal" })
vim.keymap.set("n", "<leader>rr", ":MagmaEvaluateLine<CR>", { desc = "Magma Evaluate Line" })
vim.keymap.set("x", "<leader>r", ":<C-u>MagmaEvaluateVisual<CR>", { desc = "Magma Evaluate Visual" })
vim.keymap.set("n", "<leader>ri", ":MagmaInit python3<CR>", { desc = "Initialize Magma" })
vim.keymap.set("n", "<leader>rp", ":vert<CR>:exec '!python3 '.shellescape('%')<CR>", { desc = "run python" })
