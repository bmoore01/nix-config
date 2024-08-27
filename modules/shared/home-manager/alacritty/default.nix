{...}: let
  font = "Hack Nerd Font Mono";
in {
  programs.alacritty = {
    enable = true;
    settings = {
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
