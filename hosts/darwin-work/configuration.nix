{
  pkgs,
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

  # Configure redis
  services.redis = {
    enable = true;
    extraConfig = ''
      maxmemory 256mb
      maxmemory-policy allkeys-lru
      save ""

      daemonize yes
    '';
  };

  # Enable touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  nix = {
    gc.interval = {
      Weekday = 5;
      Hour = 17;
      Minute = 0;
    };
    # This doesn't work on mac currently
    auto-optomise-store = false;
  };

  system = {
    stateVersion = 4;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
