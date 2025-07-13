{pkgs, ...}: {
  # Allows extra capabilities providied by nvim-cmp
  # https://nix-community.github.io/nixvim/plugins/cmp-nvim-lsp.html
  plugins.cmp-nvim-lsp.enable = true;

  # Useful status updates for LSP.
  # https://nix-community.github.io/nixvim/plugins/fidget/index.html
  plugins.fidget.enable = true;

  # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
  autoGroups = {
    "kickstart-lsp-attach" = {
      clear = true;
    };
  };

  plugins.lsp = {
    enable = true;

    servers = {
      lua_ls = {
        enable = true;
        settings = {
          completion = {
            callSnippet = "Replace";
          };
        };
      };
    };

    keymaps = {
      diagnostic = {
        "<leader>cq" = {
          mode = "n";
          action = "setloclist";
          desc = "Quickfix list";
        };
        "<leader>cd" = {
          action = "open_float";
          desc = "Line Diagnostics";
        };
        "[d" = {
          action = "goto_prev";
          desc = "Previous Diagnostic";
        };
        "]d" = {
          action = "goto_next";
          desc = "Next Diagnostic";
        };
      };

      lspBuf = {
        gd = {
          action = "definition";
          desc = "Goto Definition";
        };
        gr = {
          action = "references";
          desc = "Goto References";
        };
        gI = {
          action = "implementation";
          desc = "Goto Implementation";
        };
        gT = {
          action = "type_definition";
          desc = "Goto Type Definition";
        };
      };

      extra = [
        # Fuzzy find all the symbols in your current document.
        {
          mode = "n";
          key = "<leader>csl";
          action.__raw = "require('telescope.builtin').lsp_document_symbols";
          options = {
            desc = "Local search";
          };
        }
        # Fuzzy find all the symbols in your current workspace.
        {
          mode = "n";
          key = "<leader>csw";
          action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
          options = {
            desc = "Workspace search";
          };
        }
      ];
    };

    onAttach = ''
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end

      -- The following two autocommands are used to highlight references of the
      -- word under the cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following autocommand is used to enable inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    '';
  };
}
