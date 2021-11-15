set background=light
filetype plugin indent on
syntax on
set sessionoptions+=globals
let mapleader = "\<Space>"

" disable mouse to be able to select + copy
  set mouse-=a

" buffers
  nnoremap <F10> :buffers<cr>:buffer<Space>
  nnoremap <silent> <F12> :bn<cr>
  nnoremap <silent> <S-F12> :bp<cr>

" don't copy when using del
  vnoremap <Del> "_d
  nnoremap <Del> "_d

" numbers maps
  set number norelativenumber
  nnoremap <leader>hh :set relativenumber!<cr>
