{ inputs, ... }:
{
  flake.modules.homeManager.shell-utils =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.nix-index-database.homeModules.nix-index
      ];

      home = {
        # Various command line tools
        packages = [
          pkgs.tree-sitter
          pkgs.timg
          pkgs.cloc
          pkgs.curl
          pkgs.eza
          pkgs.fd
          pkgs.fzf
          pkgs.git-filter-repo
          pkgs.hexyl
          pkgs.hyperfine
          pkgs.ripgrep
          pkgs.tldr
          pkgs.wget
          pkgs.claude-code
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
    };
}
