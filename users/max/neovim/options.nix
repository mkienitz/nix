_: {
  programs.nixvim = {
    options = {
      ignorecase = true;
      termguicolors = true;
      encoding = "utf-8";
      clipboard = "unnamedplus";
      title = true;
      updatetime = 50;
      incsearch = true;
      hlsearch = false;
      number = true;
      relativenumber = true;
      cursorline = true;
      guicursor = "";
      scrolloff = 8;
      signcolumn = "yes";
      undofile = true;
      autoindent = true;
      wrap = false;
      smartindent = true;
      shiftwidth = 4;
      smarttab = true;
      tabstop = 4;
      softtabstop = 4;
      timeout = true;
      timeoutlen = 300;
    };
  };
}
