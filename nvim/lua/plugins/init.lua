-- Bootstrap lazy.nvim
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

-- Configure plugins
require("lazy").setup({
  -- tsc.nvim (TypeScript compile errors in quickfix)
  {
    "dmmulroy/tsc.nvim",
    config = function()
      require("tsc").setup()
    end,
  },
  
  -- which-key.nvim (shows keybindings in popup)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup()
    end,
  },
      -- nvim-web-devicons (provides filetype icons)
      {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = function()
          require("nvim-web-devicons").setup({
            default = true,
          })
        end,
      },
  
      -- mini.icons (provides additional icons)
      {
        "echasnovski/mini.icons",
        version = "*",
        config = function()
          require("mini.icons").setup()
        end,
  },
})
