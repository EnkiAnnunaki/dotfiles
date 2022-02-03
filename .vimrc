autocmd!

if has("nvim")
  " --- nvim-specific configuration
  source ~/.vim/init/nvim.vim
endif

source ~/.vim/init/settings.vim
source ~/.vim/init/bindings.vim
source ~/.vim/init/ale.vim
source ~/.vim/init/nerdtree.vim

" --- Plugin options

source ~/.vim/init/plugin-options.vim
