-- set ai nu smd sw=4 ts=4
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- from vimrc
vim.o.expandtab = true
vim.o.guicursor = ''
vim.o.incsearch = false
vim.o.shiftround = true

-- disable bad nvim defaults
vim.o.hlsearch = false
vim.o.startofline = true

vim.cmd 'colorscheme vim'
vim.cmd 'highlight! link LineNr Normal'
vim.cmd 'highlight! link StatusLine ModeMsg'
vim.cmd 'highlight! link StatusLineNC Normal'
vim.cmd 'highlight! link StatusLineTerm StatusLine'
vim.cmd 'highlight! link StatusLineTermNC StatusLineNc'

vim.filetype.add({
    filename = {
        ['.shrc'] = 'sh',
    },
})

vim.keymap.set('n', '`', '~')

if vim.fn.has('win32') == 1 then
    vim.keymap.set('n', '<C-z>', ':split<CR><C-w><C-w>:set nonu<CR>:terminal<CR>i')
end
