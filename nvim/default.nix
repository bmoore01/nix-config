{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  xdg.configFile."nvim".source = pkgs.stdenv.mkDerivation {
    name = "NvChad";
    version = "2.0";

    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "NvChad";
      rev = "1a98a451ea6a88a96ce24c3b78b0eeb875b05dbd";
      hash = "sha256-Q8BgwzcJChb864B3vkspa7N3g3coC6nowE9MMNKRbbE=";
    };

    installPhase = ''
      mkdir -p $out
      cp -r ./* $out/
      cd $out/
      cp -r ${./nvchad-custom-config} $out/lua/custom
    '';
  };
}
