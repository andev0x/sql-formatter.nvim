" Author: Anvndev
" File: plugin/sqlformat.vim
" Description: SQL formatting plugin for Neovim

if exists('g:loaded_sqlformat')
  finish
endif
let g:loaded_sqlformat = 1

command! -range=% SQLFormat call sqlformat#Format(<line1>, <line2>)
nnoremap <silent> <leader>sf :SQLFormat<CR>
