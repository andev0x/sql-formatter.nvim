" author: anvndev
" https://github.com/andev0x/sql-formatter.nvim
" Vim plugin file for SQL formatter

if exists('g:loaded_sql_formatter')
  finish
endif
let g:loaded_sql_formatter = 1

" Check Neovim version
if !has('nvim-0.8.0')
  echohl ErrorMsg
  echom 'sql-formatter requires Neovim >= 0.8.0'
  echohl None
  finish
endif

" Initialize plugin
lua require('sql-formatter')