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
    storageMode = "local";
    localStorageDir = inputs.self.outPath + "/secrets/rekeyed/${config.node.hostname}";
    generatedSecretsDir = config.node.secretsDir + "/generated";
  };
}
