{pkgs, ...}: {
  plugins.neo-tree = {
    enable = true;

    filesystem = {
      window = {
        mappings = {
          "\\" = "close_window";
        };
      };
    };
  };

  keymaps = [
    {
      key = "\\";
      action = "<cmd>Neotree reveal<cr>";
      options = {
        desc = "NeoTree Toggle";
      };
    }
  ];
}
