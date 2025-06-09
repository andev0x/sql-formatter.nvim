-- author: anvndev
-- https://github.com/andev0x/sql-formatter.nvim
-- SQL Formatter Module

local M = {}
local utils = require("sql-formatter.utils")

M.config = {}
M.external_available = false

function M.setup(config)
  M.config = config
end

-- Check if external formatter (sqlparse) is available
function M.check_external_formatter()
  if not M.config.external_formatter.enabled then
    return false
  end
  
  local cmd = M.config.external_formatter.command
  local handle = io.popen("which " .. cmd .. " 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  
  M.external_available = result ~= ""
  
  if not M.external_available then
    vim.notify(
      "External SQL formatter '" .. cmd .. "' not found. Install with: pip install sqlparse",
      vim.log.levels.WARN,
      { title = "SQL Formatter" }
    )
  end
  
  return M.external_available
end

-- Format SQL using external formatter (sqlparse)
function M.format_with_external(text)
  if not M.external_available then
    return nil, "External formatter not available"
  end
  
  local cmd = M.config.external_formatter.command
  local args = table.concat(M.config.external_formatter.args, " ")
  local full_cmd = string.format("echo %s | %s %s", vim.fn.shellescape(text), cmd, args)
  
  local handle = io.popen(full_cmd)
  if not handle then
    return nil, "Failed to execute formatter command"
  end
  
  local result = handle:read("*a")
  local success = handle:close()
  
  if not success then
    return nil, "Formatter command failed"
  end
  
  return result:gsub("%s+$", ""), nil -- Remove trailing whitespace
end

-- Fallback Lua-based formatter (basic)
function M.format_with_lua(text)
  local lines = vim.split(text, "\n")
  local formatted_lines = {}
  local indent_level = 0
  local indent = M.config.indent
  
  for _, line in ipairs(lines) do
    local trimmed = line:match("^%s*(.-)%s*$")
    
    if trimmed ~= "" and not utils.is_comment_line(trimmed) then
      -- Handle keywords that decrease indent
      if trimmed:upper():match("^(END|ELSE|ELSIF|WHEN)%s") then
        indent_level = math.max(0, indent_level - 1)
      end
      
      -- Apply current indentation
      local formatted_line = string.rep(indent, indent_level) .. trimmed
      
      -- Format keywords to uppercase if configured
      if M.config.uppercase then
        formatted_line = M.format_keywords(formatted_line)
      end
      
      table.insert(formatted_lines, formatted_line)
      
      -- Handle keywords that increase indent
      if trimmed:upper():match("^(SELECT|FROM|WHERE|JOIN|INNER|LEFT|RIGHT|FULL|CASE|BEGIN|IF|LOOP|WHILE)%s") or
         trimmed:upper():match("(THEN|ELSE|DO)%s*$") then
        indent_level = indent_level + 1
      end
    else
      table.insert(formatted_lines, trimmed)
    end
  end
  
  return table.concat(formatted_lines, "\n")
end

-- Format SQL keywords
function M.format_keywords(line)
  local keywords = {
    "select", "from", "where", "join", "inner", "left", "right", "full", "outer",
    "on", "and", "or", "not", "in", "exists", "between", "like", "is", "null",
    "order", "by", "group", "having", "limit", "offset", "union", "insert",
    "into", "values", "update", "set", "delete", "create", "table", "alter",
    "drop", "index", "primary", "key", "foreign", "references", "unique",
    "constraint", "default", "auto_increment", "varchar", "int", "bigint",
    "decimal", "float", "double", "boolean", "date", "datetime", "timestamp",
    "case", "when", "then", "else", "end", "if", "begin", "commit", "rollback"
  }
  
  for _, keyword in ipairs(keywords) do
    local pattern = "\\b" .. keyword .. "\\b"
    line = line:gsub(pattern, keyword:upper())
  end
  
  return line
end

-- Main format function
function M.format_sql(text)
  if M.config.external_formatter.enabled and M.external_available then
    local result, err = M.format_with_external(text)
    if result then
      return result
    else
      vim.notify("External formatter failed: " .. err, vim.log.levels.WARN)
      -- Fall back to Lua formatter
    end
  end
  
  return M.format_with_lua(text)
end

-- Format current buffer
function M.format_buffer()
  local buf = vim.api.nvim_get_current_buf()
  
  if not utils.is_sql_buffer(buf) then
    vim.notify("Not a SQL buffer", vim.log.levels.WARN)
    return
  end
  
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local text = table.concat(lines, "\n")
  
  if text:match("^%s*$") then
    vim.notify("Buffer is empty", vim.log.levels.INFO)
    return
  end
  
  local formatted = M.format_sql(text)
  local new_lines = vim.split(formatted, "\n")
  
  -- Save cursor position
  local cursor = vim.api.nvim_win_get_cursor(0)
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
  
  -- Restore cursor position (with bounds checking)
  local line_count = vim.api.nvim_buf_line_count(buf)
  cursor[1] = math.min(cursor[1], line_count)
  vim.api.nvim_win_set_cursor(0, cursor)
  
  if M.config.notify.enabled then
    vim.notify("SQL formatted successfully", vim.log.levels.INFO, { title = "SQL Formatter" })
  end
end

-- Format selected range
function M.format_range(start_line, end_line)
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, start_line - 1, end_line, false)
  local text = table.concat(lines, "\n")
  
  local formatted = M.format_sql(text)
  local new_lines = vim.split(formatted, "\n")
  
  vim.api.nvim_buf_set_lines(buf, start_line - 1, end_line, false, new_lines)
  
  if M.config.notify.enabled then
    vim.notify("SQL range formatted successfully", vim.log.levels.INFO, { title = "SQL Formatter" })
  end
end

return M