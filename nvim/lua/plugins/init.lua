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
    dependencies = { 
      "nvim-lua/plenary.nvim",
      -- Native sorter for better performance
      { 
        "nvim-telescope/telescope-fzf-native.nvim", 
        build = "make" 
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          -- Use ripgrep for faster searches
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          -- Use fd for file finding
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          -- Use fzf for sorting
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        },
        pickers = {
          find_files = {
            -- Use fdfind (Debian/Ubuntu name for fd)
            find_command = { "fdfind", "--type", "f", "--strip-cwd-prefix" }
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })
      
      -- Load the fzf extension
      require("telescope").load_extension("fzf")
      
      -- Key mappings with desc attribute for which-key to pick up
      local builtin = require('telescope.builtin')
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope Help Tags" })
      
      -- LSP related mappings
      vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Find references" })
      vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "Find definitions" })
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find document symbols" })
      vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, { desc = "Find workspace symbols" })
      
    end,
  },
})
