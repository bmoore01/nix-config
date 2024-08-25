{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      exec-once = "waybar & swaybg -m fill -i ~/Pictures/wallpapers/wallpaper.jpg &";

      input = {
        kb_layout = "us";
        kb_options = "caps:escape";
        follow_mouse = 1;
      };

      monitor = [
        # name, resolution, position, scale, tramsform rotates monitor
        "DP-1, 2560x1440@144, 1440x0, auto"
        "DP-2, 2560x1440@60, 0x0, 1, transform, 1"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 4;
        "col.active_border" = "rgba(f5bde6ff) rgba(f5bde6ff) 45deg";
        "col.inactive_border" = "rgba(363a4fff)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 12;
        blur = {
          enabled = true;
          size = 4;
          passes = 4;
          ignore_opacity = false;
        };
        active_opacity = 0.9;
        inactive_opacity = 0.7;
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
      };

      animations.enabled = "yes";

      workspace = [
        "1, monitor:DP-2"
        "2, monitor:DP-1, default:true"
      ];

      bind =
        [
          "$mod, Return, exec, alacritty"
          "$mod, F, fullscreen, 1"
          "$mod, Q, killactive,"
          "$mod, Escape, exit,"

          # Move focus
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # Move to different workspaces
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"

          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"

          "$mod CTRL, H, resizeactive, -64 0"
          "$mod CTRL, L, resizeactive, 64 0"
          "$mod CTRL, K, resizeactive, 0 -64"
          "$mod CTRL, J, resizeactive, 0 64"

          "$mod, Space, exec, rofi -show drun -show-icons"

          "$mod, R, togglesplit,"
          "$mod, V, togglefloating,"
        ]
        ++ builtins.concatLists (
          builtins.genList (
            x: let
              ws = toString (
                if x == 0
                then 10
                else x
              );
              key = toString x;
            in [
              "$mod, ${key}, workspace, ${ws}"
              "$mod SHIFT, ${key}, movetoworkspace, ${ws}"
            ]
          )
          10
        );
    };
  };
}
