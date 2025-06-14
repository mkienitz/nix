{
  programs.git = {
    enable = true;
    userName = "Maximilian Kienitz";
    userEmail = "max@kienitz.dev";
    signing.format = "ssh";
    ignores = [
      ".direnv"
      ".DS_Store"
    ];
    extraConfig = {
      core.editor = "vim";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
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
          activeBorderColor = [
            "blue"
            "bold"
          ];
          cherryPickedCommitBgColor = [ "cyan" ];
          cherryPickedCommitFgColor = [ "blue" ];
          inactiveBorderColor = [ "white" ];
          optionsTextColor = [ "blue" ];
          selectedLineBgColor = [ "default" ];
          selectedRangeBgColor = [ "default" ];
          unstagedChangesColor = [ "red" ];
        };
      };
      notARepository = "skip";
      os = {
        editPreset = "nvim";
      };
    };
  };
}
