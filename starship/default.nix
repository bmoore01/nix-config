{...}: {
  programs.starship = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      add_newline = false;
      scan_timeout = 120;

      format = ''
        [┌─$directory$git_branch$git_commit$git_status]($style)
        [└─ $nix_shell$character]($style)
      '';

      right_format = "[$cmd_duration\\[$status\\]]($style)";

      character = {
        success_symbol = "[λ](green)";
        error_symbol = "[λ](red)";
      };

      status = {
        disabled = false;
        symbol = "[$status](red)";
        success_symbol = "[$status](green)";
        format = "[$symbol$success_symbol]($style)";
      };

      git_branch = {
        format = "[ git:\\($branch:]($style)";
        style = "";
        truncation_length = 20;
      };

      git_commit = {
        format = "[\\[$hash$tag\\]]($style)";
        only_detached = false;
        tag_symbol = ":";
      };

      git_status = {
        format = "[$all_status$ahead_behind\\)]($style)";
        ahead = " ⇡$count";
        behind = " ⇣$count";
        conflicted = " =$count";
        untracked = " ?$count";
        stashed = " \\$$count";
        modified = " !$count";
        staged = " +$count";
        renamed = " »$count";
        deleted = " x$count";
      };

      nix_shell = {
        format = "[\\($symbol$name\\)]($style)";
        symbol = "❄️ ";
        style = "blue bold";
      };

      direnv = {
        disabled = false;
      };

      directory = {
        style = "cyan bg:0xDA627D";
        read_only_style = "red";

        format = "[\\[$path\\]]($style)$read_only($read_only_style)";

        home_symbol = "~";
        read_only = " ";
        repo_root_format = "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";

        truncate_to_repo = false;
        truncation_length = 6;
        truncation_symbol = "";
        use_logical_path = true;
      };
    };
  };
}
