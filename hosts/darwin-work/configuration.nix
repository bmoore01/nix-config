{
  pkgs,
  username,
  agenix,
  ...
}: {
  imports = [
    ../../modules/shared/nix
    agenix.darwinModules.default
  ];

  # Auto update nix package and the daemon service
  services.nix-daemon.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    zsh.enable = true; # default shell on catalina
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ];

  # Enable touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  system = {
    stateVersion = 4;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
