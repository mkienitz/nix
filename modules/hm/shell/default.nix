{
  pkgs,
  inputs,
  ...
}: {
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
      bat
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
      (pkgs.writeShellScriptBin "view_nixvim_output" ''
        set -e
        cp ~/.config/nvim/init.lua /tmp/pretty.lua
        chmod 600 /tmp/pretty.lua
        ${stylua}/bin/stylua /tmp/pretty.lua
        vim /tmp/pretty.lua
      '')
    ];

    shellAliases = {
      c = "clear";
      weather = "curl wttr.in/Munich";
      zz = "z -";
      ls = "eza";
      l = "eza";
      llt = "eza --long --tree";
      ll = "eza -l";
      la = "eza -la";
      tree = "eza -T";
      lg = "lazygit";
    };
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
  };

  home.persistence."/state".directories = [
    ".local/share/direnv/allow"
    ".local/share/zoxide"
  ];
}
