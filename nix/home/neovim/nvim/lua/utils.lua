local M = {}

local function map(mode, key, action)
    vim.keymap.set(mode, key, action, { silent = true })
end

-- Public functions to quickly declare keymaps

function M.nmap(key, action)
    map('n', key, action)
end

function M.vmap(key, action)
    map('v', key, action)
end

function M.xmap(key, action)
    map('x', key, action)
end

function M.imap(key, action)
    map('i', key, action)
end

function M.smap(key, action)
    map('s', key, action)
end

return M
