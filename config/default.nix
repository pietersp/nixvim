{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [ 
    ./bufferline.nix 
    ./metals.nix
    ./neo-tree.nix
    ./which-key.nix
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
}
