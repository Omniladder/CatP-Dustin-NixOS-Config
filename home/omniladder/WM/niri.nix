
{ config, pkgs, ... }:

{
   programs.niri = {
        enable = true;
        settings = {
            bindings = [
                {
                    keys = ["Mod+O"];
                    command = "spawn firefox";
                }
                {
                    keys = ["Mod+Q"];
                    command = "spawn wezterm";
                }
            ];
        };
   };
}

