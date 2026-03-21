{ pkgs, ... }:
{
    programs.zsh = {
        enable = true;

        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;

        autocd = true;

        history = {
            size = 10000;
            path = "$HOME/.zsh_history";
        };

        plugins = [{
            name = "zsh-autopair";
            src = pkgs.zsh-autopair;
        } {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }];

        initContent = ''
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
            if [[ -o interactive ]] && [[ -z "$TMUX" ]] && [[ -t 1 ]]; then
                if tmux has-session -t main 2>/dev/null; then
                    attached="$(tmux display-message -p -t main '#{session_attached}' 2>/dev/null)"
                        if [[ "$attached" -gt 0 ]]; then
                            exec tmux new-session
                        else
                            exec tmux attach-session -t main
                                fi
                else
                    exec tmux new-session -s main
                fi
            fi
        '';
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.fzf.enable = true;
}
