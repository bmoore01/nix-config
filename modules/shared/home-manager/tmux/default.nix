{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    prefix = "C-Space";
    # This is needed so that tmux launches zsh instead of bash 
    # see: https://discourse.nixos.org/t/tmux-use-bash-instead-defined-zsh-in-home-manager/54763
    sensibleOnTop = false;

    # fix escape-j issue with widow switching
    escapeTime = 0;
    historyLimit = 100000;
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
