{
  inputs,
  pkgs,
  ...
}:
{
  home = {
    packages = [
      inputs.mvim.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];
    sessionVariables.EDITOR = "nvim";
    persistence."/state".directories = [ ".cache/nvim" ];
  };
  programs = {
    zsh = {
      shellAliases = {
        vim = "nvim";
        vi = "nvim";
      };
    };
  };
}
