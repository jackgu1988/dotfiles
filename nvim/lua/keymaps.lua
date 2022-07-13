-- Switch between relative and non-relative line numbering
vim.keymap.set("n", "<C-x>", function()
    vim.opt.relativenumber = not(vim.opt.relativenumber:get())
end)

vim.keymap.set("n", "<leader>q", "<cmd>noh<CR>")    -- Clear highlights

vim.keymap.set("", "<F8>", "<cmd>NvimTreeToggle<CR>") -- Toggle NvimTree

