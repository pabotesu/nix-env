{pkgs, ...}: {
  home.packages = with pkgs; [
    aichat  # Multi-AI CLI (ChatGPT, Claude, Gemini, etc.)
  ];
}
