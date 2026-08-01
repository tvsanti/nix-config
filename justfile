# Rebuild the system from this flake
switch:
    sudo nixos-rebuild switch --flake {{justfile_directory()}}

# Update all flake inputs, rebuild, and commit the new lock
update:
    nix flake update --flake {{justfile_directory()}}
    sudo nixos-rebuild switch --flake {{justfile_directory()}}
    git -C {{justfile_directory()}} commit -m "chore: update flake.lock" flake.lock

# Check that every host still evaluates
check:
    nix flake check {{justfile_directory()}}

# Try a package without installing it (declare it in home/home.nix if it sticks)
try pkg:
    nix shell nixpkgs#{{pkg}}

# Free disk space now (also runs weekly via nix.gc.automatic)
gc:
    sudo nix-collect-garbage --delete-older-than 14d
