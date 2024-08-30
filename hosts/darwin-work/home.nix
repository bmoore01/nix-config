{...}: {
  imports = [
    # Shared home-manager modules
    ../../modules/shared/home-manager
    ../../modules/shared/home-manager/zsh
    ../../modules/shared/home-manager/emacs
    ../../modules/shared/home-manager/tmux
    ../../modules/shared/home-manager/nvim

    # Darwin specific home-manager modules
    ../../modules/darwin/home-manager/git
  ];
}
