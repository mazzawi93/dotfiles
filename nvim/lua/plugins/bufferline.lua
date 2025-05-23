return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            separator = true
          }
        },
      }
    })
    
    -- Buffer navigation keymaps
    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
    vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "Close Buffer" })
  end,
}