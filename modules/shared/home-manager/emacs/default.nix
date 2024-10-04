{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = (
      pkgs.emacsWithPackagesFromUsePackage {
	config = ./config.org;
	defaultInitFile = true;
	alwaysEnsure = true;
	alwaysTangle = true;
	package = pkgs.emacs29-pgtk;

	extraEmacsPackages = epkgs:
	  with epkgs; [
	    vterm
	    treesit-grammars.with-all-grammars
	  ];
      }
    );
  };
}
