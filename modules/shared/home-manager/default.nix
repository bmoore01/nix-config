# --------------------------------------------------------------
# Default home manager configuration, excludes imports
# as they should be specified per machine
# --------------------------------------------------------------
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
      WORKSPACE = "${homeDirectory}/workspace";
      PROJECTS = "${homeDirectory}/workspace/work/projects";
      SCRIPTS = "${homeDirectory}/workspace/work/scripts";
    };

    packages = with pkgs; [
      # Utils
      ripgrep # Find patterns in files
      fd # Find files
      jq # JSON processor
      jqp # JQ playground
      fzf # Fuzzy finder
      hyperfine # Benchmarking tool
      just # Command running

      tree
      htop
      fastfetch

      glow # Markdown previewer

      git-crypt # Secret management in git

      # Nix developer tools
      direnv
    ];
  };

  # XDG Config
  xdg = with home; {
    enable = true;
    dataHome = "${homeDirectory}/.local/share";
    stateHome = "${homeDirectory}/.local/state";
    configHome = "${homeDirectory}/.config";
    cacheHome = "${homeDirectory}/.cache";
  };

  imports = [
    ./fonts.nix
  ];

  # Let home manager install and manage itself
  programs.home-manager.enable = true;
}
