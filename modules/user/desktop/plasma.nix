{ pkgs, ... }:
{
  # TODO: finish - https://nixos.wiki/wiki/Plasma-Manager
  programs.plasma = {
    enable = true;

    # TODO: use overrideConfig in the future to ensure consistent and declarative setup
  };
}
