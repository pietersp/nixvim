{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [
    ./plugins/bufferline.nix
    ./plugins/conform.nix
    ./plugins/gitsigns.nix
    ./plugins/lsp.nix
    ./plugins/metals.nix
    ./plugins/mini.nix
    ./plugins/neo-tree.nix
    ./plugins/nvim-cmp.nix
    ./plugins/telescope.nix
    ./plugins/todo-comments.nix
    ./plugins/treesitter.nix
    ./plugins/which-key.nix
  ];

  colorschemes = {
    catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
      };
    };
  };

  opts = {
    termguicolors = true;

    # [[ Setting options ]]
    # See `:help vim.opt`
    # NOTE: You can change these options as you wish!
    #  For more options, you can see `:help option-list`
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=globals#opts
    # Show line numbers
    number = true;
    relativenumber = true;

    # Enable mouse mode, can be useful for resizing splits for example!
    mouse = "a";

    # Don't show the mode, since it's already in the statusline
    showmode = false;

    # Enable break indent
    breakindent = true;

    # Save undo history
    undofile = true;

    # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    ignorecase = true;
    smartcase = true;

    # Keep signcolumn on by default
    signcolumn = "yes";

    # Decrease update time
    updatetime = 250;

    # Decrease mapped sequence wait time
    # Displays which-key popup sooner
    timeoutlen = 300;

    # Configure how new splits should be opened
    splitright = true;
    splitbelow = true;

    # Sets how neovim will display certain whitespace characters in the editor
    #  See `:help 'list'`
    #  and `:help 'listchars'`
    list = true;
    # NOTE: .__raw here means that this field is raw lua code
    listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

    # Preview substitutions live, as you type!
    inccommand = "split";

    # Show which line your cursor is on
    cursorline = true;

    # Minimal number of screen lines to keep above and below the cursor.
    scrolloff = 10;

    # if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
    # instead raise a dialog asking if you wish to save the current file(s)
    # See `:help 'confirm'`
    confirm = true;

    # See `:help hlsearch`
    hlsearch = true;
  };

  globals = {
    # Set <space> as the leader key
    # See `:help mapleader`
    mapleader = " ";
    maplocalleader = " ";

    have_nerd_font = true;
  };

  plugins = {
    # Adds icons for plugins to utilize in ut
    web-devicons.enable = true;

    # Detect tabstop and shiftwidth automatically
    # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
    sleuth = {
      enable = true;
    };

    # "gc" to comment visual regions/lines
    # https://nix-community.github.io/nixvim/plugins/comment/index.html
    comment = {
      enable = true;
    };

    # Highlight todo, notes, etc in comments
    # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
    todo-comments = {
      enable = true;
      settings.signs = true;
    };
  };
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraplugins
  extraPlugins = with pkgs.vimPlugins; [
    # Useful for getting pretty icons, but requires a Nerd Font.
    nvim-web-devicons # TODO: Figure out how to configure using this with telescope
  ];
  keymaps = [
    # Clear highlights on search when pressing <Esc> in normal mode
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w><C-h>";
      options = {
        desc = "Move focus to the left window";
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w><C-l>";
      options = {
        desc = "Move focus to the right window";
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w><C-j>";
      options = {
        desc = "Move focus to the lower window";
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w><C-k>";
      options = {
        desc = "Move focus to the upper window";
      };
    }
  ];
  # TODO: Figure out where to move this
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapre
  extraConfigLuaPre = ''
    if vim.g.have_nerd_font then
      require('nvim-web-devicons').setup {}
    end
  '';

  # The line beneath this is called `modeline`. See `:help modeline`
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapost
  extraConfigLuaPost = ''
    -- vim: ts=2 sts=2 sw=2 et
  '';
}
