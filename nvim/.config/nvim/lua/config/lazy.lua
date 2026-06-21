-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_create_user_command('E', 'Explore <args>', { nargs = '?', complete = 'dir' })

vim.opt.expandtab = true    -- Use spaces instead of tabs
vim.opt.shiftwidth = 2     -- Size of an indent (number of spaces)
vim.opt.tabstop = 2        -- Number of spaces tabs count for
vim.opt.softtabstop = 2    -- Number of spaces tabs count for while editing

-- Highlight searches
vim.opt.hlsearch = true

-- Highlight dynamically as pattern is typed
vim.opt.incsearch = true

-- Highlight trailing whitespace
vim.opt.list = true
vim.opt.listchars = { trail = '·', tab = '» ' }


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    -- { import = "plugins" },
    {
      "loctvl842/monokai-pro.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("monokai-pro").setup()
        vim.cmd.colorscheme("monokai-pro")
      end,
    },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      -- or if using mini.icons/mini.nvim
      -- dependencies = { "nvim-mini/mini.icons" },
      ---@module "fzf-lua"
      ---@type fzf-lua.Config|{}
      ---@diagnostic disable: missing-fields
      opts = {},
      ---@diagnostic enable: missing-fields
      config = function()
        require('fzf-lua').setup_fzfvim_cmds()
      end
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        preset = "helix",
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "lua_ls", "rust_analyzer" }
      },
      dependencies = {
      { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "unokai" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
