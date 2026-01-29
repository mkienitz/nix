{ inputs, ... }:
{
  flake.modules.nixos.secrets =
    {
      config,
      ...
    }:
    {
      imports = [
        inputs.agenix.nixosModules.default
        inputs.agenix-rekey.nixosModules.default
      ];
      age.rekey = {
        masterIdentities = [
          (inputs.secrets + "/YubiKey5CNFC.pub")
          (inputs.secrets + "/YubiKey5C.pub")
        ];
        storageMode = "local";
        localStorageDir = inputs.secrets + "/rekeyed/${config.networking.hostName}";
        generatedSecretsDir = inputs.secrets + "/generated/${config.networking.hostName}";
      };
    };
}
