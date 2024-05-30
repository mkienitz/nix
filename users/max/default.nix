{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
lib.mkMerge [
  (
    lib.mkIf pkgs.stdenv.isLinux
    {
      users.users.max = {
        isNormalUser = true;
        shell = pkgs.zsh;
        inherit (config.users.users.root) hashedPassword;
      };
      security.doas.enable = true;
      security.doas.extraRules = [
        {
          users = ["max"];
          keepEnv = true;
        }
      ];
    }
  )
  {
    home-manager = {
      useGlobalPkgs = true;
      extraSpecialArgs = {
        inherit inputs;
      };
      users.max = {
        imports = [
          ../../modules/hm/gui
          ../../modules/hm/shell
          ../../modules/hm/shell/neovim
          # Always add impermanence options, even if they aren't used.
          # This avoids the need for guards.
          ../../modules/hm/impermanence.nix
        ];
        home.username = "max";
        home.stateVersion = "23.11";
      };
    };
  }
]
