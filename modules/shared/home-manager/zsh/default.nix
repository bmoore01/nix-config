{config, ...}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["direnv"];
    };

    history = {
      share = true;
      extended = true;
      ignoreDups = true;
      save = 1000000;
      size = 1000000;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };

    historySubstringSearch = {
      enable = true;
    };

    initExtraBeforeCompInit = builtins.readFile ./pre-compinit.zsh;

    initExtra = ''
      ${builtins.readFile ./completions.zsh}
      ${builtins.readFile ./functions.zsh}

      # Add personal bin binaries
      export PATH="$HOME/bin:$PATH"
      export PATH="$R9HOME/bin:$PATH"

      # Added homebrew for m1
      export PATH=/opt/homebrew/bin:$PATH
      export PATH=/opt/homebrew/sbin:$PATH
    '';
  };

  home.shellAliases = {
    c = "clear";

    history = "history -E | less";

    # safe rm
    rm = "rm -i";
    rmdir = "rmdir -i";

    ll = "ls -alh";

    g = "git ";
    gs = "git status";

    d = "dirs -v";
  };
}
