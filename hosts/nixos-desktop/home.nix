{pkgs, ...}: {
  imports = [
    # Shared home-manager modules
    ../../modules/shared/home-manager
    ../../modules/shared/home-manager/zsh
    ../../modules/shared/home-manager/starship
    ../../modules/shared/home-manager/emacs
    ../../modules/shared/home-manager/git
    ../../modules/shared/home-manager/fzf
    ../../modules/shared/home-manager/tmux
    ../../modules/shared/home-manager/nvim

    # NixOS specific home-manager modules
    ../../modules/nixos/home-manager/hyprland
    ../../modules/nixos/home-manager/waybar
  ];

  services.lorri.enable = true;

  home.packages = with pkgs; [
    neovide

    discord
    vesktop # Screen sharing for discord

    spotify

    swaybg

    jetbrains.idea-community-bin

    gf
    godot_4

    _1password-gui

    # Valve proton
    protonup
  ];

  # This is so we can install proton GE by running protonup not very declarative :(
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
