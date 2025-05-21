return {
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
  }