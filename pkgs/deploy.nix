(_final: prev: {
  deploy = prev.callPackage (
    prev.fetchFromGitHub {
      owner = "oddlama";
      repo = "nix-config";
      rev = "93061af475f718bdf3c34e69e419e3db92efabd7";
      hash = "sha256-ogTW26huURJqfFmniN512ygsTcLlh3IuY2+IOhykKjI=";
    }
    + "/pkgs/deploy.nix"
  ) { };
})
