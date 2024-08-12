{pkgs, ...}: {
  home.packages = with pkgs; [
    # utils
    ripgrep
    jq
    jqp
    fzf

    # Secret management
    git-crypt

    # Docker stuff
    docker
    colima

    # Nix developer tools
    direnv

    # command runner
    just

    # markdown previewer
    glow

    # misc
    tree
    gtop
    neofetch
  ];
}
