{
  home-manager.users.santiago = { pkgs, inputs, ... }: {
    imports = [ ./alacritty.nix ./screens.nix ];
    # Allow unfree packages
    xsession = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        config = {
          modifier = "Mod4";
          window.titlebar = false;
          terminal = "alacritty";
          menu = "rofi -show run";
        };
      };
    };
    programs.i3status = {
      enable = true;

      general = {
        colors = true;
        interval = 5;
      };

      modules = {
        ipv6 = { position = 1; };

        "wireless _first_" = {
          position = 2;
          settings = {
            format_up = "W: (%quality at %essid) %ip";
            format_down = "W: down";
          };
        };

        "ethernet _first_" = {
          position = 3;
          settings = {
            format_up = "E: %ip (%speed)";
            format_down = "E: down";
          };
        };

        "battery all" = {
          position = 4;
          settings = { format = "%status %percentage %remaining"; };
        };

        "volume master" = {
          position = 5;
          settings = {
            format = "♪ %volume";
            format_muted = "♪ muted (%volume)";
            device = "pulse:0";
          };
        };

        "disk /" = {
          position = 6;
          settings = { format = "%avail"; };
        };

        load = {
          position = 7;
          settings = { format = "%1min"; };
        };

        memory = {
          position = 8;
          settings = {
            format = "%used | %available";
            threshold_degraded = "1G";
            format_degraded = "MEMORY < %available";
          };
        };

        "tztime local" = {
          position = 9;
          settings = { format = "%Y-%m-%d %H:%M:%S"; };
        };
      };
    };

    programs.rofi = {
      enable = true;
      theme = ./rofi-dmenu-theme.rasi;
    };

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs;
      [
        pkgs.nixfmt-classic
        xsel # managing Xorg clipboard
        cachix
        anki
        zathura # pdf reader
        scrot # making screenshots
        cloc # count lines of code
        pavucontrol
        python3 # TODO: In nixos config?
        ntfs3g # TODO: In nixos config?
        gnupg
        _1password
        deluge
        slack
        inetutils # for telnet (TODO: In cli-essentials.nix?)
        krew
        jetbrains.idea-community
        feh # image viewer
        # TODO: Maybe these all in kubernetes-something
        kubernetes-helm
        kubectl
        minikube
        kubectx
        awscli
        helmfile
        kustomize
        # TODO: Maybe in virtualization
        vagrant
        podman-compose
        go
        discord
        ledger-live-desktop
        eksctl
        postman
        claude-code
        inputs.opencode.packages.${pkgs.system}.default
        clang # I just need it to build tree-sitter grammars in emacs
        lxappearance
        # TODO: Maybe put this somewhere else
        (google-cloud-sdk.withExtraComponents
          ([ google-cloud-sdk.components.app-engine-go ]))

        pgcli
        jrnl
      ] ++ import ./cli-essentials.nix { inherit pkgs; };

    services.sxhkd.enable = true;
    services.sxhkd.keybindings = { "super + o" = "firefox"; };


    programs.fzf.enable = true;
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      autocd = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
        k = "kubectl";
      };
      defaultKeymap = "emacs";

      # Move across words with Ctrl + Left/Right
      initExtra = ''
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
    };

    programs.starship = {
      enable = true;
      settings = { add_newline = false; };
    };

    programs.vscode = {
      enable = true;
      # prevents manually installing extensions, but also prevents nix-installed versions
      # from randomly breaking
      mutableExtensionsDir = false;
    };

    programs.bash.enable = true;

    programs.direnv.enable = true;

    programs.git = {
      enable = true;
      userName = "tvsanti";
      userEmail = "santithevenetvalles@gmail.com";
      aliases = {
        co = "checkout";
        ss = "status";
        cm = "commit -m";
      };
    };
    programs.mpv = {
      enable = true;
      config = {
         save-position-on-quit = true; 
         "vo" = "gpu-next";
      };
    };
    # Install firefox.
    programs.firefox.enable = true;
    
    programs.chromium.enable = true;

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.05";
  };
}
