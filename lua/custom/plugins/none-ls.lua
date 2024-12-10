local config = {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.completion.spell,
    }
  end,
}

return config
