{
  pkgs,
  pkgsUnstable,
  ...
}: {
  programs.git = {
    enable = true;
    
    settings = {
      user.name = "pabotesu";
      user.email = "pab0te2u@gmail.com";
      init.defaultBranch = "main";
      ghq.root = "~/Src";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  home.packages = with pkgsUnstable; [
    ghq
    peco
    hub
  ];
}
