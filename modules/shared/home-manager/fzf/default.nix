{...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
    fileWidgetOptions = ["--preview 'head {}'"];
    changeDirWidgetCommand = "fd --type d";
  };
}
