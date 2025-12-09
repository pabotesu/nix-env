{pkgs, ...}: {
  imports = [
    ./starship.nix
    ./direnv.nix
  ];
  home.packages = with pkgs; [
    neofetch
    eza
    ripgrep
    bat
    doggo
    jq
    nh # nic cli helper
    nurl # generate nix fetcher
    nvfetcher # nix fetcher
    yazi # file manager
    bottom # TUI system monitor
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
    initContent = 
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

        function peco-history-selection() {
        BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
        CURSOR=$#BUFFER
        zle reset-prompt
        }
        zle -N peco-history-selection
        bindkey '^R' peco-history-selection
      '';
  };
}
