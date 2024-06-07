{inputs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users.max = {
      imports = [
        ../hm/gui
        ../hm/shell
        ../hm/shell/neovim
        # Always add impermanence options, even if they aren't used.
        # This avoids the need for guards.
        ../hm/impermanence.nix
      ];
      home.username = "max";
      home.stateVersion = "23.11";
    };
  };
}
