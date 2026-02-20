{ lib, ... }:
userName:
let
  # Replace non-alphanumeric characters with dashes
  replaceNonAlphanumeric =
    s:
    lib.concatStrings (
      map (c: if builtins.match "[a-z0-9]" c != null then c else "-") (lib.strings.stringToCharacters s)
    );

  # Strip leading dashes
  stripLeadingDashes =
    s:
    let
      matched = builtins.match "-*(.*)" s;
    in
    if matched == null then s else builtins.elemAt matched 0;

  # Truncate to max length
  truncate = maxLen: s: lib.strings.substring 0 maxLen s;

  # Sanitize the username
  sanitizeUsername =
    username:
    let
      lowered = lib.strings.toLower username;
      replaced = replaceNonAlphanumeric lowered;
      stripped = stripLeadingDashes replaced;
      sanitized = truncate 20 stripped;
    in
    if sanitized == "" then throw "Error: Username cannot be empty" else sanitized;

  sanitizedUsername = sanitizeUsername userName;

  # Generate a short hash (first 7 characters of SHA-256)
  generateShortHash = s: builtins.substring 0 7 (builtins.hashString "sha256" s);

  hash = generateShortHash userName;
in
"${sanitizedUsername}-${hash}"
