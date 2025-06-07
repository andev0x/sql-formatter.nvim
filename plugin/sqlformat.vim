" Author: Anvndev
" File: plugin/sqlformat.vim
" Description: SQL formatting plugin for Neovim

if exists('g:loaded_sqlformat')
  finish
endif
let g:loaded_sqlformat = 1

" Default settings if not set by Lua
let g:sqlformat_indent = get(g:, 'sqlformat_indent', 2)
let g:sqlformat_keyword_case = get(g:, 'sqlformat_keyword_case', 'upper')
let g:sqlformat_line_width = get(g:, 'sqlformat_line_width', 80)
let g:sqlformat_format_on_save = get(g:, 'sqlformat_format_on_save', 0)

" Define command
command! -range=% SQLFormat call sqlformat#Format(<line1>, <line2>)

" Set up format on save if enabled
if g:sqlformat_format_on_save
  augroup SQLFormat
    autocmd!
    autocmd BufWritePre *.sql :SQLFormat
  augroup END
endif

" Set up default keybinding if not set by Lua
if !exists('g:sqlformat_custom_keymaps')
  nnoremap <silent> <leader>sf :SQLFormat<CR>
endif
