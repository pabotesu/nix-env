{pkgsUnstable, ...}: {
  programs = {
    vscode = {
      enable = true;
      extensions = with pkgsUnstable.vscode-extensions; [
        ms-ceintl.vscode-language-pack-ja
        oderwat.indent-rainbow
        golang.go
        eamodio.gitlens
        yzhang.markdown-all-in-one
        jnoortheen.nix-ide
      ];
      userSettings = {
        # This property will be used to generate settings.json:
        # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
        "files.insertFinalNewline" = true;
        "editor.formatOnSave" = false;
        "github.copilot.nextEditSuggestions.enabled" = true;
      };
    };
  };
}
