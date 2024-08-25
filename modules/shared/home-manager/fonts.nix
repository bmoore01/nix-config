# --------------------------------------------------------------
# File for all fonts to install
# --------------------------------------------------------------
{pkgs, ...}: {
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Hack"];})
    emacs-all-the-icons-fonts
  ];
}
