# Reload mac config
@reload-mac
  darwin-rebuild switch --flake path .

# Format nix files
@fmt
  nix fmt

# Delete result
clean:
  rm -rf result

