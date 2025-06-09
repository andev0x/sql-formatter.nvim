" author: anvndev
" https://github.com/andev0x/sql-formatter.nvim
" Vim plugin file for SQL formatter

if exists('g:loaded_sql_formatter_nvim')
  finish
endif
let g:loaded_sql_formatter_nvim = 1

" Check Neovim version
if !has('nvim-0.8.0')
  echohl ErrorMsg
  echom 'sql-formatter.nvim requires Neovim >= 0.8.0'
  echohl None
  finish
endif

" Initialize plugin with default configuration
lua require('sql-formatter').setup()