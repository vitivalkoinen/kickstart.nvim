local config = {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'github/copilot.vim' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = 'float',
        relative = 'cursor',
        width = 1,
        height = 0.4,
        row = 1,
      },
    },
    config = function()
      require('CopilotChat.integrations.cmp').setup()

      local select = require 'CopilotChat.select'
      -- You might also want to disable default <tab> complete mapping for copilot chat when doing this
      require('CopilotChat').setup {
        mappings = {
          complete = {
            insert = '',
          },
        },
        prompts = {
          Explain = {
            prompt = '/COPILOT_EXPLAIN アクティブな選択範囲の説明を段落形式で書いてください。日本語で返答ください。',
          },
          Review = {
            prompt = '/COPILOT_REVIEW 選択されたコードをレビューしてください。日本語で返答ください。',
          },
          FixCode = {
            prompt = '/COPILOT_GENERATE このコードには問題があります。バグを修正したコードに書き直してください。日本語で返答ください。',
          },
          Refactor = {
            prompt = '/COPILOT_GENERATE 明瞭性と可読性を向上させるために、次のコードをリファクタリングしてください。日本語で返答ください。',
          },
          BetterNamings = {
            prompt = '/COPILOT_GENERATE 選択されたコードの変数名や関数名を改善してください。日本語で返答ください。',
          },
          Documentation = {
            prompt = '/COPILOT_GENERATE 選択範囲にドキュメントコメントを追加してください。日本語で返答ください。',
          },
          Tests = {
            prompt = '/COPILOT_GENERATE コードのテストを生成してください。日本語で返答ください。',
          },
          Wording = {
            prompt = '/COPILOT_GENERATE 次のテキストの文法と表現を改善してください。日本語で返答ください。',
          },
          Summarize = {
            prompt = '/COPILOT_GENERATE 選択範囲の要約を書いてください。日本語で返答ください。',
          },
          Spelling = {
            prompt = '/COPILOT_GENERATE 次のテキストのスペルミスを修正してください。日本語で返答ください。',
          },
          FixDiagnostic = {
            prompt = 'ファイル内の次の問題を支援してください:',
            selection = select.diagnostics,
          },
          Commit = {
            prompt = '変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。',
            selection = select.gitdiff,
          },
          CommitStaged = {
            prompt = '変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。',
            selection = function(source)
              return select.gitdiff(source, true)
            end,
          },
        },
      }
    end,
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      -- Quick chat with Copilot
      {
        '<leader>ccq',
        function()
          local input = vim.ui.input({ prompt = 'Quick Chat: ' }, function(input)
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end)
        end,
        desc = 'CopilotChat - Quick chat',
      },
      -- Show help actions with telescope
      {
        '<leader>cch',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.help_actions())
        end,
        desc = 'CopilotChat - Help actions',
      },
      -- Show prompts actions with telescope
      {
        '<leader>ccp',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'CopilotChat - Prompt actions',
      },
    },
  },
}

return config
