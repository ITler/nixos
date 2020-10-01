  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    settings = { 
      ignorecase = true; 
      relativenumber = true;
    };
    extraConfig = ''
      set mouse=a
    '';
  };
