-- set ai nu smd sw=4 ts=4
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- from vimrc
vim.o.expandtab = true
vim.o.incsearch = false
vim.o.shiftround = true

vim.cmd 'colorscheme torte'

-- disable bad nvim defaults
vim.o.hlsearch = false
vim.o.guicursor = ''
vim.o.mouse = ''

vim.filetype.add({
    filename = {
        ['.shrc'] = 'sh',
    },
})

vim.keymap.set('n', '`', '~')

if vim.env.SHELL then
    vim.o.shell = '"' .. vim.env.SHELL .. '" -l'
end
if vim.fn.has('win32') == 1 then
    vim.keymap.set('n', '<C-z>', ':split<CR><C-w><C-w>:set nonu<CR>:terminal<CR>i')
end
