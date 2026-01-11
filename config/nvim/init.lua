-- set ai nu smd sw=4 ts=4
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- from vimrc
vim.o.expandtab = true
vim.o.guicursor = ''
vim.o.incsearch = false
vim.o.keymodel = 'startsel,stopsel'
vim.o.selection = 'exclusive'
vim.o.shiftround = true
vim.o.splitbelow = true
vim.o.splitright = true

-- disable bad nvim defaults
vim.o.hlsearch = false
vim.o.startofline = true

-- nvim
vim.o.winblend = 10

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

-- eclipse
vim.keymap.set('n', '<C-r>', ':Pick files<CR>')
if vim.fn.eval('&term') == 'ansi' then
    vim.keymap.set('n', '<BS>', ':Pick grep_live<CR>')
else
    vim.keymap.set('n', '<C-h>', ':Pick grep_live<CR>')
end

-- intellij
vim.keymap.set('n', '<C-a>', ':Pick help<CR>')
vim.keymap.set('n', '<C-e>', ':Pick buffers<CR>')

-- vscode
vim.keymap.set('n', '<C-\\>', ':vsplit<CR>')

if vim.fn.has('win32') == 1 then
    vim.keymap.set('n', '<C-z>', ':split<CR>:set nonu<CR>:terminal<CR>i')
end

vim.pack.add({
    'https://github.com/nvim-mini/mini.pick',
})

require('mini.pick').setup()
