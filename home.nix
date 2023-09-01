{
  config,
  pkgs,
  ...
}: {
  home.packages = [];
  home.stateVersion = "23.11";

  programs.git = {
    enable = true;
    userName = "Maximilian Kienitz";
    userEmail = "max@kienitz.dev";
  };

  programs.lazygit = {
    enable = true;
    settings = {
      disableStartupPopups = true;
      gui = {
        showCommandLog = true;
        showFileTree = true;
        showIcons = true;
        showListFooter = false;
        showRandomTip = false;
        theme = {
          activeBorderColor = ["blue" "bold"];
          cherryPickedCommitBgColor = ["cyan"];
          cherryPickedCommitFgColor = ["blue"];
          inactiveBorderColor = ["white"];
          optionsTextColor = ["blue"];
          selectedLineBgColor = ["default"];
          selectedRangeBgColor = ["default"];
          unstagedChangesColor = ["red"];
        };
      };
      notARepository = "skip";
      os = {editPreset = "nvim";};
    };
  };
  
  services.ssh-agent.enable = true;
}
