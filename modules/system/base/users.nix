{ pkgs, ... }:
{
  users.users.ben = {
    isNormalUser = true;
    description = "Ben";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}
