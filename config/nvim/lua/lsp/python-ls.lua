-- pip install python-language-server
require'lspconfig'.pyls.setup{}

-- npm i -g pyright
require'lspconfig'.pyright.setup{}

--   Commands:
--   - PyrightOrganizeImports: Organize Imports
--
--   Default Values:
--     cmd = { "pyright-langserver", "--stdio" }
--     filetypes = { "python" }
--     root_dir = function(filename)
--           return util.root_pattern(unpack(root_files))(filename) or
--                  util.path.dirname(filename)
--         end;
--     settings = {
--       python = {
--         analysis = {
--           autoSearchPaths = true,
--           useLibraryCodeForTypes = true
--         }
--       }
--     }
