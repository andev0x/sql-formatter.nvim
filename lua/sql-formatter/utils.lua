-- author: anvndev
-- https://github.com/andev0x/sql-formatter.nvim
-- SQL Formatter Utilities

local M = {}

-- Check if a buffer contains SQL content
function M.is_sql_buffer(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
  
  local sql_filetypes = { "sql", "mysql", "plsql", "pgsql" }
  
  for _, ft in ipairs(sql_filetypes) do
    if filetype == ft then
      return true
    end
  end
  
  return false
end

-- Check if line is a comment
function M.is_comment_line(line)
  local trimmed = line:match("^%s*(.-)%s*$")
  return trimmed:match("^%-%-") or trimmed:match("^/%*") or trimmed:match("^%*")
end

-- Get visual selection range
function M.get_visual_selection()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  
  return start_line, end_line
end

-- Check if external command exists
function M.command_exists(cmd)
  local handle = io.popen("which " .. cmd .. " 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  return result ~= ""
end

return M