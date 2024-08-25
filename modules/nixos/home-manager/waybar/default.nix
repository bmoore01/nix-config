{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "5";
        height = 30;
        #spacing = 2;
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = ["network"];

        "hyprland/workspaces" = {
          disable-scroll = true;
          disable-markup = false;
          all-outputs = true;
          format = "  {icon}  ";
          #format-icons = ["" "" "󰙯" "" "󰡨" ""];
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 120;
        };

        clock = {
          format = "{:%e %B %Y %H:%M}";
          tooltip = false;
          timezone = "Europe/Berlin";
        };

        network = {
          interval = 5;
          format-wifi = " "; # Icon: wifi
          format-ethernet = " "; # Icon: ethernet
          format-disconnected = "⚠  Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
          on-click = "nm-connection-editor";
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
