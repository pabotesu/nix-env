{
  pkgs,
  pkgsUnstable,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "pabotesu";
    userEmail = "pab0te2u@gmail.com";
    
    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      ghq.root = "~/Src";
    };
    
  };

  home.packages = with pkgsUnstable; [
    nodePackages.gitmoji-cli
    ghq
    peco
    hub
  ];
}
