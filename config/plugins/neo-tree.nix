{pkgs, ...}: {
  plugins.neo-tree = {
    enable = true;

    # filesystem = {
    #   window = {
    #     mappings = {
    #       "\\" = "close_window";
    #     };
    #   };
    # };
  };

  keymaps = [
    {
      key = "\\";
      action = "<cmd>Neotree toggle<cr>";
      options = {
        desc = "NeoTree Toggle";
      };
    }
  ];
}
