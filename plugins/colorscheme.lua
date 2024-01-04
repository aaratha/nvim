return {
  {
    "folke/tokyonight.nvim",
    opts = {
      lazy = false,
      priority = 1000,
      transparent = true,
      style = "night",
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.border = "#124239"
        colors.bg_statusline = "#124239"
        colors.bg_dark = "#124239"
      end,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
