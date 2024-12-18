{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
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
  };

  home.persistence."/state".directories = [
    ".local/share/direnv/allow"
    ".local/share/zoxide"
  ];
}
