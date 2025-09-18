{ pkgs, ... }:
{
  nix.settings.builders =
    let
      machinesFiles = pkgs.writeText "machines" ''
        ssh://glepage@aarch64-build-box.nix-community.org aarch64-linux /run/user/1000/agenix/ssh-nix-community 2 1 benchmark,big-parallel,kvm,nixos-test - c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUc5dXlmaHlsaStCUnRrNjR5K25pcXRiK3NLcXVSR0daODdmNFlSYzhFRTEK
        ssh://glepage@darwin-build-box.nix-community.org aarch64-darwin,x86_64-darwin /run/user/1000/agenix/ssh-nix-community 2 1 apple-virt,big-parallel,nixos-test - c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUtNSGhsY243ZlVwVXVpT0ZlSWhEcUJ6Qk5Gc2JOcXErTnB6dUdYM2U2enYgCg==
      '';
    in
    "@${machinesFiles}";
}
