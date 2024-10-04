{
  username,
  secrets,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/hyprland
    ../../modules/shared/nix
  ];

  # Bootloader config
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
    ];
  };

  nix.gc.dates = "weekly";

  networking.hostName = "${secrets.personal.hostname}"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  # Enable sddm display manager
  services.displayManager.sddm.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;

  # XServer configurations
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    videoDrivers = ["nvidia"];

    xkb = {
      # Set keyboard layout to use
      layout = "us";
      variant = "";

      # Set capslock to be escape key
      options = "caps:escape";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Audio configuration
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Setup noisetorch, virtual microphone with noise suppression
  programs.noisetorch.enable = true;

  # Enable Corsair keyboard/mouse driver
  hardware.ckb-next.enable = true;

  # Set global default shell to zsh
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    packages = with pkgs; [
      kate
    ];
    description = "${username}";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Setup opengl
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # Most wayland compositors need this
    nvidia.modesetting.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    # Install firefox.
    firefox.enable = true;

    # Globally install zsh
    zsh.enable = true;

    # Steam + game settings
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    gamemode.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    neovim
    curl

    wl-clipboard-x11 # Clipboard for wayland

    ckb-next # Corsair mouse/keyboard driver

    # Gaming stuff
    mangohud # Hud for monitoring FPS in games
    lutris # Game launcher
    heroic # Another Game launcher
    bottles # Wine manager
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
