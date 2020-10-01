{ pkgs, lib, ... }:

with builtins;
with lib.hm;

let
  name = "Dr. B";
  email = "ITler@users.noreply.github.com";
  githubUsername = "Dr. B";
  
  homeDir = builtins.getEnv "HOME";
  hostname = "bugs";

  dots = "${homeDir}/infra/nodes/${hostname}";
  node_config = "${homeDir}/nixos/nodes/${hostname}";

  pkgsUnstable = import <unstable>{};

  fonts = {
    name = "Source Code Pro";
    pkg = "source-code-pro";
    size = 16;
  };
  term = "xterm-termite";

  # shellspec = pkgs.stdenv.mkDerivation {
  #   name = "shellspec";
  #   buildInputs = [pkgs.docker];

  #   src = pkgs.fetchFromGitHub {
  #     owner = "shellspec";
  #     repo = "shellspec";
  #     rev = "0.27.0";
  #     sha256 = "1mwk6jvl33dcy9537n7f2r7x2l83wdchxknj7i5xd1ncj213k92s";
  #   };
  # };

  # taskfile = pkgs.buildGoModule rec {
  #   # name = "taskfile.dev-v${version}";
  #   name = "taskfile";
  #   pname = "taskfile";
  #   version = "3.0.0";

  #   src = pkgs.fetchFromGitHub {
  #     owner = "go-task";
  #     repo = "task";
  #     rev = "v${version}";
  #     sha256 = "0n6iz7j7dj9xlvwinffzks74hxca5r1wf8hypialxq6v9rq64syj";
  #   };

  #   modSha256 = "1icl1vqchjdsjzcmcicmgaay9dw2gv13r5695nmr1hmm06aj04y6";

  #   subPackages = [ "." ]; 

  #   meta = with lib; {
  #     description = "Makefile replacement, written in Go";
  #     homepage = https://github.com/go-task/task;
  #     license = licenses.mit;
  #   };
  # };

in {
  home = {
    packages = [
      pkgs.bind
      # borgbackup
      pkgs.chromium
      # conda
      pkgs.distccWrapper # Needed to compile sqlite3 for org-roam
      pkgs.dmenu
      pkgs.epdfview
      pkgs.etcher
      pkgs.fd
      pkgs.feh
      pkgs.file
      pkgs.firefox
      pkgs.fzf
      pkgs.gnome3.gucharmap
      pkgs.grim
      pkgs.imagemagick
      pkgs.inetutils
      pkgs.ispell
      # inkscape
      pkgsUnstable.keepassxc
      #keybase-gui
      pkgs.libnotify
      pkgs.libvterm
      pkgs.ncdu
      pkgs.nix-bundle
      pkgs.nixfmt
      # obs-studio
      # obs-wlrobs
      # pandoc
      pkgs.pass-wayland
      pkgs.pavucontrol
      pkgs.qutebrowser
      pkgs.ripgrep
      pkgs.shellcheck
      # shotwell
      pkgs.slurp
      pkgs.sqlite
      pkgs.steam-run # run binaries not meant for nixos
      pkgs.sway
      pkgs.termite
      # texlive.combined.scheme-medium
      pkgs.veracrypt
      pkgs.waybar
      pkgs.wl-clipboard
      pkgs.xdg_utils
      pkgs.ydotool
      pkgs.zathura
      pkgs.zoom-us
      # (writeShellScriptBin "zfs_backup"
        # (builtins.readFile "${homeDir}/scripts/zfs_backup"))

      pkgs.ansible
      pkgs.docker-compose
      pkgs.go
      pkgs.gocode
      pkgs.godef
      pkgs.gotools
      pkgs.graphviz
      pkgs.hadolint
      pkgs.jq
      pkgs.nix-direnv
      pkgsUnstable.awscli2
      pkgs.python3
      pkgs.sops
      pkgs.swaks

      # shellspec
      # taskfile
    ];
  };
  imports = [
    # ./devtools.nix
    # ~/nixos/services/taskfile
    # ~/nixos/services/tutorial
  ];

  programs.home-manager = {
    enable = true;
    path = "${dots}";
  };
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = { decorations = "none"; };
      font.normal.family = fonts.name;
      font.size = fonts.size;
      background_opacity = 0.94;
      # Colors (Solarized Dark)
      colors = {
        primary.background = "0x002b36";
        primary.foreground = "0x839496";
        normal = {
          black = "0x073642";
          red = "0xdc322f";
          green = "0x859900";
          yellow = "0xb58900";
          blue = "0x268bd2";
          magenta = "0xd33682";
          cyan = "0x2aa198";
          white = "0xeee8d5";
        };
        bright = {
          black = "0x002b36";
          red = "0xcb4b16";
          green = "0x586e75";
          yellow = "0x657b83";
          blue = "0x839496";
          magenta = "0x6c71c4";
          cyan = "0x93a1a1";
          white = "0xfdf6e3";
        };
      };
    };
  };
  # programs.irssi = {
    # enable = true;
    # networks = {
      # freenode = {
        # nick = "evernite";
        # server = {
          # address = "chat.freenode.net";
          # port = 6697;
          # autoConnect = true;
        # };
        # channels = { nixos.autoJoin = true; };
        # autoCommands = [ "/ignore -channels #nixos * JOINS PARTS QUITS NICKS" ];
      # };
    # };
  # };

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };

  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    matchBlocks = {
      # "aspati-wireguard" = {
        # hostname = "aspati.v.cip.li";
        # user = "nixos";
        # identityFile = "${homeDir}/.ssh/${hostname}_ed25519";
        # port = 42822;
      # };
      # "aspati" = {
        # hostname = "aspati.fritz.box";
        # user = "nixos";
        # identityFile = "${homeDir}/.ssh/${hostname}_ed25519";
        # port = 42822;
      # };
      "github" = {
        hostname = "github.com";
        user = "git";
        identityFile = "${homeDir}/.ssh/${hostname}_ed25519";
      };
      # "loki" = {
        # hostname = "frade01.d.cip.li";
        # user = "nixos";
        # identityFile = "${homeDir}/.ssh/${hostname}_ed25519";
        # port = 42822;
      # };
      # "wrangler-01" = {
        # hostname = "wrangler-01.mopeds.signavio.com";
        # user = "sd";
        # identityFile = "${homeDir}/.ssh/${hostname}_ed25519";
        # port = 42822;
      # };
      # "wrangler-02" = {
        # hostname = "wrangler-02.mopeds.signavio.com";
        # user = "ubuntu";
        # identityFile = "${homeDir}/.ssh/${hostname}_ed25519";
        # port = 42822;
      # };

    };
    extraConfig = "VerifyHostKeyDNS yes";
  };
  programs.firefox = {
    enable = true;
    profiles = {
      myprofile = {
        settings = {
          "general.smoothScroll" = false;
        };
      };
    };
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Don't use vi keybindings in unknown terminals,
      # since weird things can happen.
      set acceptable_terms xterm-256color screen-256color xterm-termite
      if contains $TERM $acceptable_terms
        fish_vi_key_bindings
      end
    '';
    functions = {
      reverse_history_search = ''
        history | fzf --no-sort | read -l command
        if test $command
           commandline -rb $command
        end'';
      fish_user_key_bindings = "bind \\cr reverse_history_search";
    };
  };
  programs.qutebrowser = { enable = true; };
  programs.git = {
    enable = true;
    userName = githubUsername;
    userEmail = email;
  };
  programs.dircolors.enable = true;
  
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ tcomment_vim vim-airline vim-nix vim-lastplace ];
    settings = { 
      ignorecase = true; 
      relativenumber = true;
    };
    extraConfig = ''
      set backspace=indent,eol,start
      set clipboard=unnamed
      set hidden
      set mouse=a
      set nocompatible
      set number

      set exrc
      set secure

      set modeline
      set modelines=4
    '';
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };

  services.keybase = {
    enable = true;
  };

  gtk = {
    enable = true;
    font.name = "Sans 8";
    iconTheme.name = "breeze-dark";
    theme.name = "Arc-Dark";
    gtk2.extraConfig = ''
      gtk-cursor-theme-name="Breeze_Amber"
      gtk-cursor-theme-size=0
      gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
      gtk-toolbar-icon-size=GTK_ICON_SIZE_SMALL_TOOLBAR
      gtk-button-images=0
      gtk-menu-images=0
      gtk-enable-event-sounds=0
      gtk-enable-input-feedback-sounds=0
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
    gtk3.extraConfig = {
      gtk-cursor-theme-name = "Breeze_Amber";
      gtk-cursor-theme-size = 0;
      gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_SMALL_TOOLBAR";
      gtk-button-images = 0;
      gtk-menu-images = 0;
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      # gtk-decoration-layout=menu:close
      # gtk-application-prefer-dark-theme=1
    };
  };
  systemd.user.services."password-store-backup-to@origin" = {
    Unit = { Description = "Push password-store repository to %i"; };
    Service = { ExecStart = ''
        ${pkgs.pass}/bin/pass git pull ;
        ${pkgs.pass}/bin/pass git push %i master
      ''; 
    };
  };
  systemd.user.timers."password-store-backup-to@origin" = {
    Timer = { OnCalendar = "daily"; };
  };
  # systemd.user.services."password-store-backup-to@loki" = {
    # Unit = { Description = "Push password-store repository to %i"; };
    # Service = { ExecStart = "${pkgs.pass}/bin/pass git push %i master"; };
  # };
  # systemd.user.timers."password-store-backup-to@loki" = {
    # Timer = { OnCalendar = "daily"; };
  # };
  systemd.user.startServices = true;
  xdg = {
    enable = true;
    configFile = {
      "chromium-flags.conf".text = ''
        --ignore-gpu-blacklist
        --enable-gpu-rasterization
        --enable-native-gpu-memory-buffers
        --enable-zero-copy
        --force-device-scale-factor=1.0
      '';
      "qutebrowser/quickmarks".source = "${dots}/qutebrowser/quickmarks";
      "qutebrowser/config.py".source = "${dots}/qutebrowser/config.py";
      "sway".source = "${dots}/sway/";
      "waybar".source = "${dots}/waybar/";
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    chromium = { enableWideVine = true; };
  };
  home.stateVersion = "20.03";
  home.activation.symlinkQutebrowserDataFile =
    dag.entryAfter [ "writeBoundary" ] ''
      [ ! -L $XDG_DATA_HOME/qutebrowser ] &&
       ln -sn ${dots}/qutebrowser/private/ $XDG_DATA_HOME/qutebrowser
    '';
  # home.activation.InstallQutebrowserDictionaries =
    # dag.entryAfter [ "symlinkQutebrowserDataFile" ] ''
      # ${pkgs.qutebrowser}/share/qutebrowser/scripts/dictcli.py install en-US
      # ${pkgs.qutebrowser}/share/qutebrowser/scripts/dictcli.py install de-DE
    # '';
  # home.activation.symlinkFishDataFile = dag.entryAfter [ "writeBoundary" ] ''
    # ln -sf ${dots}/fish/private/fish_history $XDG_DATA_HOME/fish/
  # '';
  # home.activation.symlinkGnupg = dag.entryAfter [ "writeBoundary" ] ''
    # [ ! -L $HOME/.gnupg ] &&
    # ln -sn $HOME/infra/services/gnupg/private $HOME/.gnupg
  # '';
  # home.activation.initializePasswordStore =
    # dag.entryAfter [ "writeBoundary" ] ''
      # [ ! -d $HOME/.password-store ] &&
      # git clone $HOME/infra/services/git/password-store $HOME/.password-store
    # '';
  # home.activation.linkSSHKeys = dag.entryAfter [ "writeBoundary" ] ''
    # [ ! -L $HOME/.ssh ] &&
    # ln -sn $HOME/infra/services/ssh/private/ $HOME/.ssh
  # '';
  home.activation.linkAWS = dag.entryAfter [ "writeBoundary" ] ''
    [ ! -L $HOME/.aws ] &&
    ln -sn $HOME/nixos/services/.aws $HOME/.aws
  '';
  home.activation.initializeDoomEmacs = dag.entryAfter [ "writeBoundary" ] ''
    [ ! -d $HOME/.emacs.d ] &&
    git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.emacs.d &&
    $HOME/.emacs.d/bin/doom install
  '';
  home.activation.linkDoom = dag.entryAfter [ "initalizeDoomEmacs" ] ''
    [ -d $HOME/.emacs.d ] && [ ! -L $HOME/.doom.d ] && (
      rm -fr $HOME/.doom.d ;
      ln -sn $HOME/nixos/services/.doom.d $HOME/.doom.d &&
      ln -sn ${node_config}/.doom.d/ $HOME/.doom.d/nodes
    )
  '';
}
