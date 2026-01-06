-- set ai nu smd sw=4 ts=4
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- from vimrc
vim.o.expandtab = true
vim.o.incsearch = false
vim.o.shiftround = true

vim.cmd 'colorscheme vim'

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
