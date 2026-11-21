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
vim.o.wildmode = 'longest,list'

-- disable bad nvim defaults
vim.o.hlsearch = false
vim.o.mouse = ''
vim.o.startofline = true
vim.o.undofile = true

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
vim.keymap.set('n', '<C-BS>', 'db')
vim.keymap.set('n', '<C-Del>', 'dw')
vim.keymap.set('i', '<C-BS>', '<C-o>db')
vim.keymap.set('i', '<C-Del>', '<C-o>dw')

-- eclipse
vim.keymap.set('n', '<C-r>', ':Pick files<CR>')
vim.keymap.set('n', '<C-h>', ':Pick grep_live<CR>')

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
