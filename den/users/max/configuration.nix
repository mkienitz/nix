{ inputs, ... }:
{
  flake.modules.nixos.max = {
    imports = with inputs.self.modules.nixos; [
    ];
  };

  flake.modules.darwin.max = {
    imports = with inputs.self.modules.darwin; [
      homebrew
    ];
  };

  flake.modules.homeManager.max = {
    imports = with inputs.self.modules.homeManager; [
      # TODO find better way to include impermanence
      impermanence
      karabiner

      fonts
      ghostty

      ssh
      stylix

      git
      mvim
      shell-utils
      starship
      tmux
      zsh
    ];
  };
}
