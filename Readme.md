Make sure that in each configuration.nix -> hostname = my-super-pc
WARNING!! It takes the hostname of your pc
1. hostname -> my-super-pc
2. sudo nixos-rebuild switch --flake . //my-super-pc


CHANGE HOSTNAME TEMPORALY BEFORE CHANGE FLAKE HOST
1. sudo hostname my-super-pc




TODO:
1. move package into home configuratino
2. reuse duplicated stuff