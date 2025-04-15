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
    opts = {
      -- default configuration for which-key
    },
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
  
  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
      -- Key mappings with desc attribute for which-key to pick up
      vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Find buffers" })
    end,
  },
})
