{
  programs.nixvim = {
    maps.normal."<leader>n" = {
      action = ":Neotree action=focus reveal toggle<CR>";
      silent = true;
    };

    plugins.neo-tree = {
      enable = true;

      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
      };

      # Fix NerdFont icons
      defaultComponentConfigs = {
        icon = {
          folderEmpty = "󰜌";
          folderEmptyOpen = "󰜌";
        };
        gitStatus = {
          symbols = {
            renamed = "󰁕";
            unstaged = "󰄱";
          };
        };
      };
      documentSymbols = {
        kinds = {
          File = {
            icon = "󰈙";
            hl = "Tag";
          };
          Namespace = {
            icon = "󰌗";
            hl = "Include";
          };
          Package = {
            icon = "󰏖";
            hl = "Label";
          };
          Class = {
            icon = "󰌗";
            hl = "Include";
          };
          Property = {
            icon = "󰆧";
            hl = "@property";
          };
          Enum = {
            icon = "󰒻";
            hl = "@number";
          };
          Function = {
            icon = "󰊕";
            hl = "Function";
          };
          String = {
            icon = "󰀬";
            hl = "String";
          };
          Number = {
            icon = "󰎠";
            hl = "Number";
          };
          Array = {
            icon = "󰅪";
            hl = "Type";
          };
          Object = {
            icon = "󰅩";
            hl = "Type";
          };
          Key = {
            icon = "󰌋";
            hl = "";
          };
          Struct = {
            icon = "󰌗";
            hl = "Type";
          };
          Operator = {
            icon = "󰆕";
            hl = "Operator";
          };
          TypeParameter = {
            icon = "󰊄";
            hl = "Type";
          };
          StaticMethod = {
            icon = "󰠄 ";
            hl = "Function";
          };
        };
      };
    };
  };
}
