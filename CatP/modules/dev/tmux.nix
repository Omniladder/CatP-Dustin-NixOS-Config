{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      catppuccin
      resurrect
      continuum
      yank
      vim-tmux-navigator
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set-option -sa terminal-overrides ",xterm*:Tc"

      unbind C-b
      set -g prefix C-b
      bind C-b send-prefix

      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"

      bind -n C-i swap-pane -U
      bind -n C-o swap-pane -D

      set -g set-clipboard on
      setw -g mode-keys vi

      set -g @catppuccin_flavour "mocha"

      # vim-tmux-navigator
      set -g @vim_navigator_mapping_left "C-h"
      set -g @vim_navigator_mapping_down "C-j"
      set -g @vim_navigator_mapping_up "C-k"
      set -g @vim_navigator_mapping_right "C-l"
      set -g @vim_navigator_mapping_prev ""

      bind-key -T copy-mode-vi C-h select-pane -L
      bind-key -T copy-mode-vi C-j select-pane -D
      bind-key -T copy-mode-vi C-k select-pane -U
      bind-key -T copy-mode-vi C-l select-pane -R
    '';
  };
}
