{
    networking.wg-quick.interfaces.wg0 = {

        address = [ "10.10.10.5/32" ];

        privateKeyFile = "/home/gaetan/dotfiles/secrets/wireguard/cuda-privatekey";
    };
}
