return 
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- List of languages to install
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "python",
          "typescript",
          "javascript",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
          "html",
          "css",
          "tsx",
          "toml",
        },
        auto_install = true,     -- Automatically install missing parsers
        highlight = {
          enable = true,         -- Enable syntax highlighting
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,         -- Use Tree-sitter for indentation (some languages still buggy)
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-backspace>",
          },
        },
      })
    end,
  }
