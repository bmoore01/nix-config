{
  username,
  ...
}: {
  nix = {
    settings = {
      trusted-users = ["root" "${username}"];
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      max-jobs = "auto";

      # Optimise storage
      # You can also run this manually with:
      #  nix-store --optimise
      # From https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      # If set to true, Nix automatically detects files in the store that have identical contents,
      # and replaces them with hard links to a single copy. This saves disk space.
      auto-optimise-store = true;
    };

    # Set nix to perform garbage collection every week to reduce disk usage
    gc = {
      automatic = true;
      options = "--delete-older-than 1w";
    };
  };
}
