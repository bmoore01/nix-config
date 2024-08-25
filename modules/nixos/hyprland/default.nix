{pkgs, ...}: {
  programs.hyprland = {
    enable = true;

    # Enable xwayland for x compatibility
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # Hyprland session variables
    # Stop cursos becoming invisible
    WLR_NO_HARDWARE_CURSORS = "1";

    # Tell electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    # Wayland system clipboard
    pkgs.wl-clipboard

    # Hyprland packages
    waybar
    rofi-wayland
    libnotify
  ];
}
