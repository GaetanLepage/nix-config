{
    networking.wg-quick.interfaces.wg0 = {

        address = [ "10.10.10.2/32" ];

        privateKeyFile = "/home/gaetan/dotfiles/secrets/wireguard/tuxedo-privatekey";
    };
}
