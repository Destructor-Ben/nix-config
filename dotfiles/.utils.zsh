ns() {
    cd ~/nix-config
    git add .
    sudo nixos-rebuild switch --flake ~/nix-config
}

nd() {
    nix develop .#$1 --command zsh
}

nds() {
    nix develop ~/nix-config#$1 --command zsh
}
