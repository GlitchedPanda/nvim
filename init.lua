-- lazy init

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- nvim config
vim.g.mapleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- lazy setup

require("lazy").setup({
	"RRethy/vim-illuminate",
	"tpope/vim-surround",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-web-devicons" }
	},
	"tc50cal/vim-terminal",
	"lambdalisue/suda.vim",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"mattn/emmet-vim",
	"preservim/vimux",
	"christoomey/vim-tmux-navigator",
	"nvim-treesitter/nvim-treesitter",
	{
		"nvim-tree/nvim-tree.lua",
  		version = "*",
  		lazy = false,
  		dependencies = {
  		  "nvim-tree/nvim-web-devicons",
  		},
  		config = function()
  		  require("nvim-tree").setup {}
  		end,
	},
	"nvim-tree/nvim-web-devicons",
	{
    		"nvim-telescope/telescope.nvim",
      		dependencies = { 'nvim-lua/plenary.nvim' }
    	},
	"nvim-treesitter/nvim-treesitter-context",
	{
  		"L3MON4D3/LuaSnip",
  		dependencies = { "rafamadriz/friendly-snippets" },
	},
	"saadparwaiz1/cmp_luasnip",
	"williamboman/mason.nvim",
    	"williamboman/mason-lspconfig.nvim",
    	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
  	"hrsh7th/cmp-nvim-lsp",
	"neovim/nvim-lspconfig",
})

-- colorscheme

vim.cmd.colorscheme 'catppuccin'

-- keybinds

vim.keymap.set('n', '<C-s>', '<CMD>w<CR>', { noremap = true })
vim.keymap.set('n', '<C-k>', '<CMD>Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', '<C-j>', '<CMD>TerminalSplit bash<CR>', { noremap = true })

-- plugin setup

require('nvim-web-devicons').setup()

require('lualine').setup {
	options = {
		theme = 'nightfly'
	}
}

require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = { 'typos_lsp', 'clangd', 'lua_ls' },
}

require('luasnip.loaders.from_vscode').lazy_load()
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
        		require('luasnip').lsp_expand(args.body)
      		end
	},
	mapping = cmp.mapping.preset.insert({
      		['<C-b>'] = cmp.mapping.scroll_docs(-4),
      		['<C-f>'] = cmp.mapping.scroll_docs(4),
      		['<C-Space>'] = cmp.mapping.complete(),
      		['<C-e>'] = cmp.mapping.abort(),
      		['<CR>'] = cmp.mapping.confirm({ select = true })
    	}),
	sources = cmp.config.sources({
      		{ name = 'nvim_lsp' },
      		{ name = 'luasnip' }
    	}, {
      	{ name = 'buffer' }
    	})
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').typos_lsp.setup {
	capabilities = capabilities
}
require('lspconfig').clangd.setup {
	capabilities = capabilities
}
require('lspconfig').lua_ls.setup {
	capabilities = capabilities
}

-- nvim tree config

local function open_nvim_tree()
  require('nvim-tree.api').tree.open()
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })

local function tree_on_attach(bufnr)
  local api = require ("nvim-tree.api")

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', '<C-f>', function() api.tree.open() end)
  vim.keymap.set('n', '<C-t>', function() api.tree.toggle() end)
end

require('nvim-tree').setup { on_attach = tree_on_attach }
