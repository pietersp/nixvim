{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [ 
    ./plugins/bufferline.nix 
    ./plugins/metals.nix
    ./plugins/neo-tree.nix
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
    number = true;
    relativenumber = true;

    termguicolors = true;
  };

  globals = {
    # Set <space> as the leader key
    # See `:help mapleader`
    mapleader = " ";
    maplocalleader = " ";

    have_nerd_font = true;
  };

  plugins = {
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
  keymaps = [
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
}
