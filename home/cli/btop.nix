{ ... }:

{
    programs.btop = {

        enable = true;

        settings = {

            color_theme     = "gruvbox_dark";
            vim_keys        = true;
            update_ms       = 1000;
            disks_filter    = "";
            mem_graphs      = false;
            net_iface       = "wlo1";
        };
    };
}