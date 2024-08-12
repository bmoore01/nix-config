local M = {}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },

    ["<leader>h"] = { "<cmd> split<CR>", "Split window horizontally" },
    ["<leader>v"] = { "<cmd> vsplit<CR>", "Split window vertically", },


    ["<A-b>"] = { function ()
      print("It works!")
    end},

    ["<A-L>"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    }
  }
}

M.lspconfig = {
  plugin = true,
  n = {
    ["<A-B>"] = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      "LSP implementation",
    },
    ["<A-b>"] = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "LSP references",
    },
    ["<D-R>"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },
  }
}



M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<A-F>"] = {
      function()
        require("telescope.builtin").live_grep()
      end,
      "Live grep"
    },

    ["<A-f>"] = {
      function()
        require("telescope.builtin").current_buffer_fuzzy_find()
      end,
      "Find in current buffer"
    },


    -- bookmarks
    ["<A-2>"] = {
      function()
        require("telescope.builtin").marks()
      end,
      "Show marks"
    },

    -- Buffers
    ["<leader>bb"] = {
      function()
        require("telescope.builtin").buffers()
      end,
      "Show open buffers"
    }
  },
}


M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },
}


M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-T>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-j>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-J>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-T>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-j>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-J>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },
}


M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Add breakpoint at line" },
    ["<leader>dr"] = { "<cmd> DapContinue <CR>", "Start or continue the debugger" }
  }
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<A-1>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

return M
