{...}: let
  font = "Hack Nerd Font Mono";
in {
  xdg.configFile."alacritty/cyberdream.toml".source = ./cyberdream.toml;
  xdg.configFile."alacritty/cyberdream-light.toml".source = ./cyberdream-light.toml;

  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "~/.config/alacritty/cyberdream.toml"
        #"~/.config/alacritty/cyberdream-light.toml"
      ];
      window = {
        title = "Terminal";
        opacity = 0.8;
        option_as_alt = "Both";
      };
      scrolling.history = 10000;
      font = {
        size = 16;
        normal = {
          family = font;
          style = "Regular";
        };
        bold = {
          family = font;
          style = "Bold";
        };
        italic = {
          family = font;
          style = "Italic";
        };
      };

      keyboard.bindings = [
        {
          key = "b";
          mods = "Command";
          action = "ReceiveChar";
        }
        {
          key = "f";
          mods = "Command";
          action = "ReceiveChar";
        }
      ];
    };
  };
}
