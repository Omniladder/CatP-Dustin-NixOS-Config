{ config, pkgs, ... }:

{
  programs.git.config = {
    init = {
       defaultBranch = "master";
    };
  };

}
