{
  pkgs,
  config,
  ...
}: {
  stylix = {
    autoEnable = false;
    image = config.lib.stylix.pixel "base00";
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  };
}
