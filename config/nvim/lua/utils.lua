local function map(mode, key, action, opts)
    local options = {
        noremap = true,
        silent = true
    }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_set_keymap(mode, key, action, options)
end

utils = {}

function utils.nmap(key, action, opts)
    map('n', key, action, opts)
end


function utils.vmap(key, action, opts)
    map('v', key, action, opts)
end

function utils.xmap(key, action, opts)
    map('x', key, action, opts)
end

local cmd = vim.cmd

function utils.create_augroup(name, autocmds)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    cmd('augroup END')
end

return utils
