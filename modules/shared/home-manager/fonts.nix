# --------------------------------------------------------------
# File for all fonts to install
# --------------------------------------------------------------
{pkgs, ...}: {
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Hack" "JetBrainsMono"];})
    emacs-all-the-icons-fonts
  ];

  fonts.fontconfig.enable = true;
}
