{
  programs.nixvim = {
    plugins.tagbar = {
      enable = true;
      extraConfig.width = 50;
    };

    # TODO mapping
    # require 'utils'.nmap('<C-g>', ':TagbarToggle<CR>')
  };
}
