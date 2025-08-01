{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    ./mvim.nix
    ./git.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home = {
    # Various command line tools
    packages = with pkgs; [
      tree-sitter
      timg
      cloc
      curl
      eza
      fd
      fzf
      git-filter-repo
      hexyl
      hyperfine
      ripgrep
      tldr
      wget
      (claude-code.overrideAttrs (_oldAttrs: rec {
        version = "1.0.65";
        nodejs = nodejs_22;
        src = fetchzip {
          url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
          hash = "sha256-xx7Nksfa0IN18i6MoU60olnY/BioS+W+OQmyETQYDHI=";
        };
      }))
    ];
  };

  programs = {
    nix-index-database.comma.enable = true;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    bat = {
      enable = true;
      config.theme = "gruvbox-dark";
    };
    yazi.enable = true;
  };

  home.persistence."/state".directories = [
    ".local/share/direnv/allow"
    ".local/share/zoxide"
  ];
}
