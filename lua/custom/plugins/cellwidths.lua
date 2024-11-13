local config = {
  {
    'delphinus/cellwidths.nvim',
    config = function()
      local cellwidths = require 'cellwidths'
      cellwidths.setup {
        name = 'default',
      }
    end,
  },
}

return config
