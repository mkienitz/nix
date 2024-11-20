# TODO: Move this?
{ inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users.max = {
      imports = [
        # Modules
        ../../modules/hm
        # Default config
        ../hm/gui
        ../hm/shell
        ../hm/shell/neovim
      ];
      home.username = "max";
      home.stateVersion = "23.11";
    };
  };
}
