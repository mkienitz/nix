_: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        indent = true;
        incrementalSelection = {
          enable = true;
          keymaps = {
            initSelection = "<C-space>";
            nodeIncremental = "<C-space>";
            scopeIncremental = "<C-S-space>";
            nodeDecremental = "<bs>";
          };
        };
      };
      treesitter-context.enable = true;
      treesitter-textobjects = {
        enable = true;
        select = {
          enable = true;
          lookahead = true;
          includeSurroundingWhitespace = true;
          keymaps = {
            "a=" = {
              query = "@assignment.outer";
              desc = "Select outer part of an assignment";
            };
            "i=" = {
              query = "@assignment.inner";
              desc = "Select inner part of an assignment";
            };
            "l=" = {
              query = "@assignment.lhs";
              desc = "Select left side of an assignment";
            };
            "r=" = {
              query = "@assignment.rhs";
              desc = "Select right side of an assignment";
            };
            "aa" = {
              query = "@parameter.outer";
              desc = "Select outer part of a parameter/field";
            };
            "ia" = {
              query = "@parameter.inner";
              desc = "Select inner part of a parameter/field";
            };
            "ai" = {
              query = "@conditional.outer";
              desc = "Select outer part of a conditional";
            };
            "ii" = {
              query = "@conditional.inner";
              desc = "Select inner part of a conditional";
            };
            "al" = {
              query = "@loop.outer";
              desc = "Select outer part of a loop";
            };
            "il" = {
              query = "@loop.inner";
              desc = "Select inner part of a loop";
            };
            "ab" = {
              query = "@block.outer";
              desc = "Select outer part of a block";
            };
            "ib" = {
              query = "@block.inner";
              desc = "Select inner part of a block";
            };
            "af" = {
              query = "@call.outer";
              desc = "Select outer part of a function call";
            };
            "if" = {
              query = "@call.inner";
              desc = "Select inner part of a function call";
            };
            "ac" = {
              query = "@class.outer";
              desc = "Select outer part of a class";
            };
            "ic" = {
              query = "@class.inner";
              desc = "Select inner part of a class";
            };
          };
        };
        move = {
          enable = true;
          gotoNextStart = {
            "]m" = {
              query = "@function.outer";
              desc = "Next function start";
            };
            "]]" = {
              query = "@class.outer";
              desc = "Next class start";
            };
          };
          gotoNextEnd = {
            "]M" = {
              query = "@function.outer";
              desc = "Next function end";
            };
            "][" = {
              query = "@class.outer";
              desc = "Next class ends";
            };
          };
          gotoPreviousStart = {
            "[m" = {
              query = "@function.outer";
              desc = "Previous function start";
            };
            "[[" = {
              query = "@class.outer";
              desc = "Previous class start";
            };
          };
          gotoPreviousEnd = {
            "[M" = {
              query = "@function.outer";
              desc = "Previous function end";
            };
            "[]" = {
              query = "@class.outer";
              desc = "Previous class end";
            };
          };
        };
        swap = {
          enable = true;
          swapNext = {
            "<leader>a" = {
              query = "@parameter.inner";
              desc = "Swap parameter with next";
            };
          };
          swapPrevious = {
            "<leader>A" = {
              query = "@parameter.inner";
              desc = "Swap parameter with next";
            };
          };
        };
      };
    };
  };
}
