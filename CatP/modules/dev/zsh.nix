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
        '';
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.fzf.enable = true;
}
