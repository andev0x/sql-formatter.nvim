" Author: Anvndev
" File: autoload/sqlformat.vim
" Description: Autoloaded functions for SQL formatting

function! sqlformat#Format(startline, endline) abort
  " Ensure Python3 is available
  if !has('python3')
    echohl ErrorMsg
    echomsg 'SQLFormat requires Neovim with +python3 support'
    echohl None
    return
  endif

  " Get the selected lines
  let l:lines = getline(a:startline, a:endline)
  let l:input = join(l:lines, '\n')

  " Call Python script to format SQL
  python3 << EOF
import vim
from sqlformat import format_sql

try:
    input_sql = vim.eval('l:input')
    indent = int(vim.eval('g:sqlformat_indent'))
    keyword_case = vim.eval('g:sqlformat_keyword_case')
    line_width = int(vim.eval('g:sqlformat_line_width'))
    
    formatted = format_sql(
        input_sql,
        indent=indent,
        keyword_case=keyword_case,
        line_width=line_width
    )
    vim.command('let l:formatted = ' + repr(formatted))
except Exception as e:
    vim.command('let l:error = ' + repr(str(e)))
EOF

  " Check for Python errors
  if exists('l:error')
    echohl ErrorMsg
    echomsg 'SQLFormat error: ' . l:error
    echohl None
    return
  endif

  " Replace buffer content with formatted SQL
  let l:formatted_lines = split(l:formatted, '\n')
  call setline(a:startline, l:formatted_lines)
endfunction
