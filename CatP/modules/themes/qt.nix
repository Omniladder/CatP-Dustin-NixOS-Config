{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
  ];

  qt = {
    enable = true;

    platformTheme.name = "qtct";

#    style = {
#      name = "kvantum";
#      package = pkgs.kdePackages.qtstyleplugin-kvantum;
#    };
  };

}
