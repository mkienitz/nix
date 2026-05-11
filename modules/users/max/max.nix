{
  inputs,
  ...
}:
{
  flake.modules.nixos.max =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        inputs.self.modules.nixos.home-manager
      ];
      users.users.max = {
        isNormalUser = true;
        home = "/home/max";
        shell = pkgs.zsh;
        inherit (config.users.users.root) hashedPassword;
        extraGroups = [
          "plugdev"
          "pcscd"
        ];
      };
      programs.zsh.enable = true;

      security.doas = {
        enable = true;
        extraRules = [
          {
            users = [ "max" ];
            keepEnv = true;
          }
        ];
      };

      home-manager.users.max = {
        imports = [
          inputs.self.modules.homeManager.max
        ];
      };
    };

  flake.modules.darwin.max =
    { pkgs, ... }:
    {
      imports = [
        inputs.self.modules.darwin.home-manager
      ];
      users.users.max = {
        name = "max";
        home = "/Users/max";
        uid = 501;
        shell = pkgs.zsh;
      };

      home-manager.users.max = {
        imports = [
          inputs.self.modules.homeManager.max
          inputs.self.modules.homeManager.impermanence-glue
        ];
      };

      system.primaryUser = "max";
      programs.zsh.enable = true;
    };

  flake.modules.homeManager.max = {
    home.username = "max";
    home.stateVersion = "25.11";
    home.persistence."/persist".directories = [
      "/Git"
      "/Downloads"
    ];
  };
}
