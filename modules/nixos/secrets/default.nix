{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.agenix.nixosModules.default
    inputs.agenix-rekey.nixosModules.default
  ];
  age.rekey = {
    masterIdentities = [./YubiKey5CNFC_master_identity.pub];
    cacheDir = "/tmp/agenix-rekey";
    forceRekeyOnSystem = "aarch64-darwin";
    storageMode = "derivation";
    generatedSecretsDir = config.node.secretsDir + "/generated";
  };
}
