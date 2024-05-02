(_final: prev: {
  deploy = prev.callPackage (prev.fetchFromGitHub
    {
      owner = "oddlama";
      repo = "nix-config";
      rev = "124e1c289f39e0f43b249d361a56286d3b6d87d6";
      hash = "sha256-7+EnNwttjsUGVrI+pT9OWcoJU7Nx0lpOcy0k9A1zZdY=";
    }
    + "/pkgs/deploy.nix") {};
})
