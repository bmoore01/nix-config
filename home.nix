{
  pkgs,
  username,
  ...
}: rec {
  home = {
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/${username}"
      else "/home/${username}";
    stateVersion = "22.11";

    sessionVariables = with home; {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";

      WORKSPACE = "${homeDirectory}/workspace";
      PROJECTS = "${homeDirectory}/workspace/work/projects";
      SCRIPTS = "${homeDirectory}/workspace/work/scripts";
    };
  };

  # XDG Config
  xdg = with home; {
    enable = true;
    dataHome = "${homeDirectory}/.local/share";
    stateHome = "${homeDirectory}/.local/state";
    configHome = "${homeDirectory}/.config";
    cacheHome = "${homeDirectory}/.cache";
  };

  # Let home manager install and manage itself
  programs.home-manager.enable = true;

  imports = [
    ./programs.nix
    #./alacritty
    ./zsh
    ./starship
    ./git/work-git.nix
    ./tmux
    ./nvim
  ];
}
