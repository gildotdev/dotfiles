call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

lua require'nvim-tree'.setup {}

nnoremap /t :NvimTreeToggle<CR>
