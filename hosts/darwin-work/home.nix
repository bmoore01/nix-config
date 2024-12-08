{pkgs, ...}: {
  imports = [
    # Shared home-manager modules
    ../../modules/shared/home-manager
    ../../modules/shared/home-manager/zsh
    ../../modules/shared/home-manager/starship
    ../../modules/shared/home-manager/emacs
    ../../modules/shared/home-manager/tmux
    ../../modules/shared/home-manager/nvim
    ../../modules/shared/home-manager/kitty
    ../../modules/shared/home-manager/zellij

    # Darwin specific home-manager modules
    ../../modules/darwin/home-manager/git
  ];

  home.packages = with pkgs; [
    # Docker stuff
    colima
    docker
    docker-buildx
  ];
}
