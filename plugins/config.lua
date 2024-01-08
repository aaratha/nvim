return {
  {
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            -- sets the language to use, 'vim' and 'python' are supported
            language = "python",
            -- 0 turns off fuzzy matching
            -- 1 turns on fuzzy matching
            -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
            fuzzy = 1,
          }),
          wilder.python_search_pipeline({
            -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
            pattern = wilder.python_fuzzy_pattern(),
            -- omit to get results in the order they appear in the buffer
            sorter = wilder.python_difflib_sorter(),
            -- can be set to 're2' for performance, requires pyre2 to be installed
            -- see :h wilder#python_search() for more details
            engine = "re",
          })
        ),
      })
      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(
          wilder.popupmenu_border_theme({
            highlights = {
              border = "Normal", -- highlight to use for the border
            },
            -- 'single', 'double', 'rounded' or 'solid'
            -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
            border = "rounded",
            min_width = "100%", -- minimum height of the popupmenu, can also be a number
            min_height = "30%", -- to set a fixed height, set max_height to the same value
            max_height = "30%",
            pumblend = 20,
          })
          -- wilder.popupmenu_palette_theme({
          --     -- 'single', 'double', 'rounded' or 'solid'
          --     -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
          --     border = 'rounded',
          --     max_height = '75%',      -- max height of the palette
          --     min_height = 0,          -- set to the same as 'max_height' for a fixed height window
          --     prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
          --     reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
          -- })
        )
      )
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 90, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        wezterm = {
          enabled = true,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
      },
    },
    {
      "nvim-orgmode/orgmode",
      dependencies = {
        {
          "nvim-treesitter/nvim-treesitter",
          lazy = true,
          require("nvim-treesitter.configs").setup({
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = { "org" }, -- < This one
            },
            ensure_installed = { "org" },
          }),
        },
        { "akinsho/org-bullets.nvim" },
        { "dhruvasagar/vim-table-mode" },
      },
      event = "VeryLazy",
      config = function()
        -- Load treesitter grammar for org
        require("orgmode").setup_ts_grammar()

        -- Setup treesitter
        require("nvim-treesitter.configs").setup({
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "org" },
          },
          ensure_installed = { "org" },
        })

        -- Setup orgmode
        require("orgmode").setup({
          org_default_notes_file = "~/OneDrive/org/notes.org",
          org_agenda_files = { "~/OneDrive/org/**" },
          org_agenda_skip_scheduled_if_done = true,
          org_agenda_skip_deadline_if_done = true,
          org_agenda_skip_if_done = true,
          org_hide_emphasis_markers = true,
          org_todo_keywords = { "TODO(t)", "COMING-UP(c)", "IN-PROGRESS(p)", "|", "DONE(d)" },
          concealcursor = "nvic",
          foldlevelstart = 1,
          mappings = {
            global = {},
          },
        })
        vim.cmd([[
          :autocmd BufNewFile,BufRead *.org setlocal conceallevel=2
          :autocmd BufNewFile,BufRead *.org setlocal concealcursor=nc
          :autocmd BufNewFile,BufRead *.org setlocal wrap
          :autocmd BufNewFile,BufRead *.org setlocal linebreak
          :autocmd BufNewFile,BufRead *.org setlocal foldlevel=0
          :autocmd BufNewFile,BufRead notes.org setlocal textwidth=66
          :autocmd BufNewFile,BufRead notes.org setlocal colorcolumn=+2
        ]])
        require("org-bullets").setup({
          concealcursor = true, -- If false then when the cursor is on a line underlying characters are visible
          symbols = {
            list = "•",
            headlines = { " ", "󰺕 ", "✸", "✿" },
            checkboxes = {
              half = { "", "OrgTSCheckboxHalfChecked" },
              done = { "✓", "OrgDone" },
              todo = { "×", "OrgTODO" },
            },
          },
        })
        -- require("headlines").setup()
      end,
    },
  },
  {
    "kdheepak/lazygit.nvim",
    config = function()
      require("lazy").setup({
        {
          "kdheepak/lazygit.nvim",
          dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
          },
          config = function()
            require("telescope").load_extension("lazygit")
          end,
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    "razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        popup_input = {
          submit = "<CR>",
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "nanozuki/tabby.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("tabby.tabline").set(function(line)
        local theme = {
          fill = "TabLineFill",
          -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
          head = "TabLine",
          -- current_tab = 'TabLineSel',
          current_tab = { fg = "#F8FBF6", bg = "#896a98", style = "italic" },
          tab = "TabLine",
          win = "TabLine",
          tail = "TabLine",
        }
        return {
          {
            { "  ", hl = theme.head },
            line.sep("", theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep("", hl, theme.fill),
              tab.is_current() and "" or "",
              tab.number(),
              tab.name(),
              -- tab.close_btn(''), -- show a close button
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          -- shows list of windows in tab
          -- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          --   return {
          --     line.sep('', theme.win, theme.fill),
          --     win.is_current() and '' or '',
          --     win.buf_name(),
          --     line.sep('', theme.win, theme.fill),
          --     hl = theme.win,
          --     margin = ' ',
          --   }
          -- end),
          {
            line.sep("", theme.tail, theme.fill),
            { "  ", hl = theme.tail },
          },
          hl = theme.fill,
        }
      end)
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    "dccsillag/magma-nvim",
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
 _____  ___    _______    ______  ___      ___  __     ___      ___ 
(\"   \|"  \  /"     "|  /    " \|"  \    /"  ||" \   |"  \    /"  |
|.\\   \    |(: ______) // ____  \\   \  //  / ||  |   \   \  //   |
|: \.   \\  | \/    |  /  /    ) :)\\  \/. ./  |:  |   /\\  \/.    |
|.  \    \. | // ___)_(: (____/ //  \.    //   |.  |  |: \.        |
|    \    \ |(:      "|\        /    \\   /    /\  |\ |.  \    /:  |
 \___|\____\) \_______) \"_____/      \__/    (__\_|_)|___|\__/|___|
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "e OneDrive/org/notes.org",                                 desc = " Enter OrgMode",   icon = "", key = "o" },
          { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
          { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end
      return opts
    end,
  },
  -- {
  --   "benlubas/molten-nvim",
  --   version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
  --   build = ":UpdateRemotePlugins",
  --   init = function()
  --     -- this is an example, not a default. Please see the readme for more configuration options
  --     vim.g.molten_output_win_max_height = 12
  --   end,
  -- },
  -- {
  --   "3rd/image.nvim",
  --   require("image").setup({
  --     backend = "kitty",
  --     integrations = {
  --       markdown = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
  --       },
  --       neorg = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { "norg" },
  --       },
  --     },
  --     max_width = nil,
  --     max_height = nil,
  --     max_width_window_percentage = nil,
  --     max_height_window_percentage = 50,
  --     window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
  --     window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  --     editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  --     tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  --     hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
  --   }),
  -- },
  -- {
  --   "edluffy/hologram.nvim",
  --   opts = function()
  --     require("hologram").setup({
  --       auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
  --     })
  --   end,
  -- },
  { "dhruvasagar/vim-table-mode" },
  -- { "yuttie/comfortable-motion.vim" },
  { "kblin/vim-fountain" },
}
