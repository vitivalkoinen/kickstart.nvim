local config = {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style = 'storm',
  },
  config = function()
    require('tokyonight').setup {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    }
    vim.cmd [[colorscheme tokyonight-storm]]
  end,
}

return config
