{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [ 
    ./bufferline.nix 
    ./catppuccin.nix
    ./metals.nix
    ./neo-tree.nix
    ./which-key.nix
  ];

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
}
