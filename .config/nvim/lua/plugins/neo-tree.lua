-- neo-tree.lua (https://github.com/nvim-neo-tree/neo-tree.nvim)
--  Neovim plugin to manage the file system and other tree like structures.

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  cond = function() return not vim.g.started_by_firenvim end,
  cmd = 'Neotree',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    {
      's1n7ax/nvim-window-picker',
      config = function()
        local config = require('config')

        require 'window-picker'.setup({
          use_winbar = 'always',
          -- the foreground (text) color of the picker
          fg_color = config.theme.colors.fg,
          -- if you have include_current_win == true, then current_win_hl_color will
          -- be highlighted using this background color
          current_win_hl_color = config.theme.colors.orange_bg,
          -- all the windows except the curren window will be highlighted using this
          -- color
          other_win_hl_color = config.theme.colors.green_bg,
        })
      end,
    }
  },
  keys = {
    {
      '<C-\\>',
      '<Cmd>Neotree filesystem toggle reveal position=right<CR>',
      mode = { 'n', 'v' },
      desc = 'Toggle file explorer'
    },
    {
      'gx', -- Restore URL handling from disabled netrw plugin
      function()
        if vim.fn.has('mac') == 1 then
          vim.cmd [[call jobstart(['open', expand('<cfile>')], {'detach': v:true})]]
        elseif vim.fn.has('unix') == 1 then
          vim.cmd [[call jobstart(['xdg-open', expand('<cfile>')], {'detach': v:true})]]
        else
          print('Error: gx is not supported on this OS!')
        end
      end,
      'Open URL'
    },
  },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require('neo-tree')
      end
    end
  end,
  opts = function()
    ---@diagnostic disable: undefined-field
    local icons = require('config').icons
    ---@diagnostic enable: undefined-field

    vim.fn.sign_define('DiagnosticSignError', { text = icons.diagnostics.error, texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = icons.diagnostics.warning, texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = icons.diagnostics.info, texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = icons.diagnostics.hint, texthl = 'DiagnosticSignHint' })

    return {
      default_component_configs = {
        icon = {
          folder_empty      = icons.folder.empty,
          folder_empty_open = icons.folder.empty_open,
          folder_closed     = icons.folder.collapsed,
          folder_open       = icons.folder.expanded
        },
        indent = {
          expander_collapsed = icons.expander.collapsed,
          expander_expanded  = icons.expander.expanded,
          expander_highlight = 'NeoTreeExpander',
        },
        modified = {
          symbol = icons.symbols.modified,
        },
        git_status = {
          symbols = {
            -- Change type
            deleted  = icons.symbols.removed, -- this can only be used in the git_status source
            renamed  = icons.symbols.renamed, -- this can only be used in the git_status source
            -- Status type
            unstaged = icons.symbols.unstaged,
          }
        },
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles   = false,
          hide_gitignored = true,
          hide_hidden     = true, -- only works on Windows for hidden files/directories
          hide_by_name    = {
            '.git',
            'node_modules',
          },
          hide_by_pattern = { -- uses glob style patterns
            '*.zwc',
          },
          never_show      = { -- remains hidden even if visible is toggled to true, this overrides always_show
            '.DS_Store',
            'thumbs.db'
          },
        },
        find_args = {
          fd = {
            '-uu',
            '--exclude',
            '.git',
            '--exclude',
            'node_modules',
            '--exclude',
            'target',
          },
        },
      },
      window = {
        position = 'right',
        mappings = {
          ['<space>'] = 'none',
        },
      },
    }
  end,
  config = function(_, opts)
    require('neo-tree').setup(opts)

    -- refresh neotree git status when closing a lazygit terminal
    vim.api.nvim_create_autocmd('TermClose', {
      pattern = '*lazygit',
      callback = function()
        if package.loaded['neo-tree.sources.git_status'] then
          require('neo-tree.sources.git_status').refresh()
        end
      end,
    })
  end,
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
}
