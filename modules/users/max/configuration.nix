{
  inputs,
  ...
}:
{
  flake.modules.darwin.max = {
    imports = with inputs.self.modules.darwin; [
      homebrew
    ];
  };

  flake.modules.homeManager.max = {
    imports = with inputs.self.modules.homeManager; [
      agents
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
