{pkgs, ...}: {
  imports = [./starship.nix];
  home.packages = with pkgs; [
    neofetch
    eza
    ripgrep
    bat
    doggo
  ];
  programs.zsh = {
    enable = true;
    autocd = true; # cdなしでファイルパスだけで移動
    enableCompletion = true; # 自動補完
    autosuggestion.enable = true; # 入力サジェスト
    syntaxHighlighting.enable = true; # シンタックスハイライト
    shellAliases = {
      cat = "bat";
      grep = "rg";
      ls = "eza --icons --classify=auto";
      la = "eza --all --icons --classify=auto";
      ll = "eza --long --all --git --icons --classify=auto";
      tree = "eza --icons --classify=auto --tree";
      nix-direnv = "echo 'use flake' >> .envrc && direnv allow";
    };
    initExtra = 
      ''
        # setup peco & ghq
        function peco-src() {
          local selected_dir=$(ghq list -p | peco --prompt="repositories >" --query "$LBUFFER")
          if [ -n "$selected_dir" ]; then
            BUFFER="cd $selected_dir"
            zle accept-line
          fi
          zle clear-screen
        }
        zle -N peco-src
        bindkey '^]' peco-src
      '';
  };
}
