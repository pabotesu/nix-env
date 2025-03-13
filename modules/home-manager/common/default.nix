{
  outputs,
  userConfig,
  envTheme,
  pkgs,
  ...
}: {
  imports = [
    ../programs/aerospace
    ../programs/ghostty
    ../programs/google-chrome
  ];
};