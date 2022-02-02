local M = {}

-- function map(mode, key, mode)
--     vim.keymap.set()
-- end

function M.nmap(key, action)
    vim.keymap.set('n', key, action,
                   { silent = true })
end

function M.vmap(key, action)
    vim.keymap.set('v', key, action,
                   { silent = true })
end

function M.xmap(key, action)
    vim.keymap.set('x', key, action,
                   { silent = true })
end

function M.imap(key, action)
    vim.keymap.set('i', key, action,
                   { silent = true })
end

function M.smap(key, action)
    vim.keymap.set('s', key, action,
                   { silent = true })
end

local cmd = vim.cmd

function M.create_augroup(name, autocmds)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    cmd('augroup END')
end

return M
