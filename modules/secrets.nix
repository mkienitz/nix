{ inputs, ... }:
{
  flake.modules.nixos.secrets =
    {
      ...
    }:
    {
      imports = [
        inputs.agenix.nixosModules.default
        inputs.agenix-rekey.nixosModules.default
        inputs.self.modules.generic.secrets
      ];
    };
  flake.modules.darwin.secrets =
    {
      ...
    }:
    {
      imports = [
        inputs.agenix.darwinModules.default
        inputs.agenix-rekey.darwinModules.default
        inputs.self.modules.generic.secrets
      ];
    };
  flake.modules.generic.secrets =
    {
      config,
      ...
    }:
    {
      age.rekey = {
        masterIdentities = [
          (inputs.secrets + "/YubiKey5C.pub")
          (inputs.secrets + "/YubiKey5CNFC.pub")
        ];
        storageMode = "local";
        localStorageDir = inputs.secrets + "/rekeyed/${config.networking.hostName}";
        generatedSecretsDir = inputs.secrets + "/generated/${config.networking.hostName}";
      };
    };
}
