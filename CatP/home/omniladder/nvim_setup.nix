{ pkgs, inputs, ... }:

{

   xdg.configFile."nvim".source = inputs.nvim-config;
   programs.neovim.defaultEditor = true;

    # Required packages for plugins
   home.packages = with pkgs; [
    ripgrep
    nodejs
    python3
    gcc
    cargo
    unzip
    go
   ];

}
