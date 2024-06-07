{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix = {
    autoEnable = false;
    # FIXME: why does this need to be set as a NixOS option?
    image = config.lib.stylix.pixel "base00";
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  };
}
