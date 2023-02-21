{
  cmd = ["pylsp"];
  # cmd = [ "pylsp" "-vvv" "--log-file" "pylsp.log"];
  enable = true;
  settings = {
    # Enable flake8
    configurationSources = "flake8";
    plugins = {
      flake8 = {
        enabled = true;
        maxLineLength = 100;
        ignore = [
          "D100" # Missing docstring in public module
          "D101" # Missing docstring in public class
          "D105" # Missing docstring in magic method
          "D107" # Missing docstring in __init__
          "D200" # One-line docstring should fit on one line with quotes
          "D205" # 1 blank line required between summary line and description
          "D400" # First line should end with a period
          "D402" # First line should not be the function's "signature"
          "D401" # First line should be in imperative mood
          "N812" # Lowercase imported as non lowercase (prevents `import torch.functionnal as F`)
          "W503" # line break before binary operator
        ];
      };
      pylint = {
        enabled = false;
        executable = "pylint";
        args = [
          "--generated-members"
          "'torch.*'"
          (
            "--disable="
            + "C0115," # missing-class-docstring
            + "C0116," # missing-function-docstring
            + "R0902," # too-many-instance-attributes
            + "R0903," # too-few-public-methods
            + "R0915" # too-many-statements
          )
        ];
      };
      pylsp_mypy = {
        enabled = true;
        live_mode = false;
        dmypy = true;
      };
      jedi_completion.fuzzy = true;
      # We don't need those as flake8 is already providing such features.
      mccabe.enabled = false;
      pyflakes.enabled = false;
      pydocstyle.enabled = false;
      preload.enabled = false;
    };
  };
}
