vim.cmd [[packadd packer.nvim]]

local use = require('packer').use
require('packer').startup(function()
    use "wbthomason/packer.nvim"

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    -- Autocompletion
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    -- vsnip
    use "hrsh7th/cmp-vsnip"
    use "hrsh7th/vim-vsnip"

    -- Languages
    -- Python
    use "averms/black-nvim"

    -- VCS
    use {
        "lewis6991/gitsigns.nvim",
        tag = "release"
    }

    -- UI
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }
    use "kyazdani42/nvim-tree.lua"

    -- Functionallity
    use "Pocco81/AutoSave.nvim" -- Autosave
end)

