{
  secrets,
  lib,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;

    userName = lib.mkDefault "bmoore01";
    userEmail = lib.mkDefault "${secrets.github.email}";

    lfs = {
      enable = true;
      skipSmudge = true;
    };

    extraConfig = {
      init.defaultBranch = "main";

      pull.rebase = true;
      push.autoSetupRemote = true;

      core = {
        fsmonitor = true;
        untrackedCache = true;
      };

      rerere.enabled = true;

      index.version = 4;
    };

    delta = {
      enable = true;
      options = {
        features = "side-by-side";
      };
    };

    aliases = {
      # common aliases
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      staash = "stash --all";
      amend = "commit --amend -m";
    };
  };
}
