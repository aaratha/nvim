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
        { "nvim-treesitter/nvim-treesitter", lazy = true },
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
          concealcursor = "nc",
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
    event = "VimEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
}
