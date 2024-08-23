{pkgs, ...}: {
  home.packages = with pkgs; [
    # utils
    ripgrep
    jq
    jqp
    fzf
    hyperfine

    neovide

    python312Packages.ipython


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
