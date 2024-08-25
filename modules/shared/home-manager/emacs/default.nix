{
  pkgs,
  config,
  lib,
  ...
}: {
  home.file.".emacs.d/init.el".text = builtins.readFile ./init.el;
  home.file.".emacs.d/config.org".text = builtins.readFile ./config.org;

  programs.emacs = {
    enable = true;
    package = with pkgs; ((emacsPackagesFor emacs29-gtk3).emacsWithPackages (epkgs: with epkgs; [vterm treesit-grammars.with-all-grammars]));
  };
}
