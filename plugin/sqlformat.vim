" Author: Anvndev
" Description: SQL formatting plugin for Neovim using sqlparse

if exists('g:loaded_sqlformat')
  finish
endif
let g:loaded_sqlformat = 1

" Default settings
let g:sqlformat_indent = get(g:, 'sqlformat_indent', 2)
let g:sqlformat_keyword_case = get(g:, 'sqlformat_keyword_case', 'upper')

" Define command
command! -range=% SQLFormat call sqlformat#Format(<line1>, <line2>)

" Keybinding (optional, customizable by user)
nnoremap <silent> <leader>sf :SQLFormat<CR>
