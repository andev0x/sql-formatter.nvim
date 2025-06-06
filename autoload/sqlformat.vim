" Author: Anvndev
" File: autoload/sqlformat.vim
" Description: Autoloaded functions for SQL formatting

function! sqlformat#Format(startline, endline) abort
  if !has('python3')
    echohl ErrorMsg
    echomsg 'SQLFormat requires Neovim with +python3 support'
    echohl None
    return
  endif

  let l:lines = getline(a:startline, a:endline)
  let l:input = join(l:lines, '\n')

  python3 << EOF
import vim
from sqlformat import format_sql
input_sql = vim.eval('l:input')
formatted = format_sql(input_sql)
vim.command('let l:formatted = ' + repr(formatted))
EOF

  let l:formatted_lines = split(l:formatted, '\n')
  call setline(a:startline, l:formatted_lines)
endfunction
