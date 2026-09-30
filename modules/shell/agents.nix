{ inputs, ... }:
{
  flake.modules.homeManager.agents =
    {
      pkgs,
      ...
    }:
    {
      home = {
        packages = [
          # For PDF analysis
          pkgs.poppler-utils
        ]
        ++ (
          let
            llm-pkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
          in
          [
            llm-pkgs.claude-code
            llm-pkgs.codex
            llm-pkgs.pi
          ]
        );
      };

      home.persistence."/state".directories = [
        ".claude"
        ".pi"
        ".codex"
      ];
      home.persistence."/state".files = [
        ".claude.json"
      ];
    };
}
