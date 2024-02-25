{inputs, ...}: {
  imports = [
    inputs.agenix.nixosModules.default
    inputs.agenix-rekey.nixosModules.default
  ];
  age.rekey.masterIdentities = [./YubiKey5CNFC_master_identity.pub];
  age.rekey.cacheDir = "/tmp/agenix-rekey";
  age.rekey.forceRekeyOnSystem = "aarch64-darwin";
}
