{
  pkgs,
  ...
}: {
  imports = [
    # Shared home-manager modules
    ../../modules/shared/home-manager
    ../../modules/shared/home-manager/zsh
    ../../modules/shared/home-manager/starship
    ../../modules/shared/home-manager/emacs
    ../../modules/shared/home-manager/git
    ../../modules/shared/home-manager/tmux
    ../../modules/shared/home-manager/nvim

    # NixOS specific home-manager modules
    ../../modules/nixos/home-manager/hyprland
    ../../modules/nixos/home-manager/waybar
  ];

  home.packages = with pkgs; [
    discord
    spotify

    swaybg
    mypaint
  ];
}
