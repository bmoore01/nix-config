{...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    prefix = "C-Space";

    # fix escape-j issue with widow switching
    escapeTime = 0;
    historyLimit = 100000;
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
