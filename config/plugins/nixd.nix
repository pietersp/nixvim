
{pkgs, ...}: {
  plugins.lsp.servers.nixd.enable = true;
  lsp.servers.nixd.enable = true;
}
