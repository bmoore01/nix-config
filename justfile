# List available recipies
default:
  @just --list

# Rebuild and reload mac config
[macos]
reload:
  darwin-rebuild switch --flake path .

# Rrebuild and reload nixos config (Requires sudo)
[linux]
reload:
  nixos-rebuild switch

# Rebuild and reload only home-manager dotfiles
reload-home-manager:
  home-manager switch --flake path:$(pwd)

# Format nix files
fmt:
  nix fmt

# Delete result
clean:
  rm -rf result

