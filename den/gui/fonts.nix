{
  flake.modules.homeManager.fonts =
    { pkgs, ... }:
    {
      fonts.fontconfig.enable = true;
      home.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];
    };
}
