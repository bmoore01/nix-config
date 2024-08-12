{
  username,
  secrets,
  ...
}: {
  imports = [./default.nix];

  programs.git = {
    userName = "${username}";
    userEmail = "${secrets.work.email}";

    includes = [
      {
        contents = {
          user = {
            name = "bmoore01";
            email = "${secrets.personal.github.email}";
          };
          core.sshCommand = "${secrets.personal.github.sshCommand}";
        };

        condition = "gitdir:~/workspace/personal/projects/";
      }
    ];
  };
}
