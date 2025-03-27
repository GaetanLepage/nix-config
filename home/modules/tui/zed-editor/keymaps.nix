[
  {
    bindings = {
      ctrl-o = "projects::OpenRecent";
      ctrl-shift-o = "workspace::Open";
      ctrl-t = "workspace::NewCenterTerminal";
    };
  }
  {
    context = "Editor";
    bindings = {
      ctrl-b = [
        "editor::ToggleComments"
        { advance_downwards = false; }
      ];
      "space h" = "pane::RevealInProjectPanel";
    };
  }
  {
    context = "Editor && VimControl && !VimWaiting && !menu";
    bindings = {
      # "space b": "editor::ToggleGitBlame",
      # "shift-k": "editor::Hover",
      # "space l f": "editor::Format",
      # "space d": "diagnostics::Deploy",
      # "space f f": "file_finder::Toggle",
      # "space o": "tab_switcher::Toggle",
      # "space e": "workspace::ToggleLeftDock",
      # "space /": "workspace::NewSearch",
      # "n": "search::SelectNextMatch",
      # "shift-n": "search::SelectPrevMatch",
      # "space t": "workspace::NewCenterTerminal",
      # "g b": "editor::ToggleComments",
      # "+ +": "workspace::Save",
      # "space c": "pane::CloseActiveItem"
      # ctrl-space = "worksterminal::"
    };
  }
  {
    context = "Terminal || Editor";
    bindings = {
      alt-h = "pane::ActivatePreviousItem";
      alt-l = "pane::ActivateNextItem";
      alt-j = "terminal_panel::ToggleFocus";
      alt-k = "terminal_panel::ToggleFocus";
    };
  }
  {
    context = "vim_mode == normal";
    bindings = {
      # tab = "pane::ActivateNextItem";
      # shift-tab = "pane::ActivatePreviousItem";
      ctrl-w = [
        "pane::CloseActiveItem"
        { close_pinned = false; }
      ];
    };
  }
]
