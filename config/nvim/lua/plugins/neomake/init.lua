-- when to activate neomake
vim.cmd("call neomake#configure#automake('nrw', 50)")

-- which linter to enable for Python source file linting
vim.g.neomake_python_enabled_makers = {'pylint'}
