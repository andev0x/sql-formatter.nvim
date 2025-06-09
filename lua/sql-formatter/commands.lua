-- author: anvndev
-- https://github.com/andev0x/sql-formatter.nvim
-- SQL Formatter Commands

local M = {}
local formatter = require("sql-formatter.formatter")

M.config = {}

function M.setup(config)
  M.config = config
  M.create_commands()
end

function M.create_commands()
  -- SQLFormat command
  vim.api.nvim_create_user_command("SQLFormat", function()
    formatter.format_buffer()
  end, {
    desc = "Format SQL in current buffer"
  })
  
  -- SQLFormatRange command
  vim.api.nvim_create_user_command("SQLFormatRange", function(opts)
    formatter.format_range(opts.line1, opts.line2)
  end, {
    range = true,
    desc = "Format SQL in selected range"
  })
  
  -- SQLFormatToggle command
  vim.api.nvim_create_user_command("SQLFormatToggle", function()
    M.toggle_format_on_save()
  end, {
    desc = "Toggle format-on-save for current buffer"
  })
  
  -- SQLFormatInfo command
  vim.api.nvim_create_user_command("SQLFormatInfo", function()
    M.show_info()
  end, {
    desc = "Show SQL formatter information"
  })
end

function M.toggle_format_on_save()
  local buf = vim.api.nvim_get_current_buf()
  local current = vim.b[buf].sql_format_on_save
  
  if current == nil then
    current = M.config.format_on_save
  end
  
  vim.b[buf].sql_format_on_save = not current
  local status = vim.b[buf].sql_format_on_save and "enabled" or "disabled"
  
  vim.notify("Format-on-save " .. status .. " for current buffer", vim.log.levels.INFO)
end

function M.show_info()
  local external_status = formatter.external_available and "Available" or "Not available"
  
  local info = {
    "SQL Formatter Information:",
    "  External formatter: " .. external_status,
    "  Dialect: " .. M.config.dialect,
    "  Format on save: " .. tostring(M.config.format_on_save),
    "  Supported filetypes: " .. table.concat(M.config.filetypes, ", "),
  }
  
  vim.notify(table.concat(info, "\n"), vim.log.levels.INFO, { title = "SQL Formatter" })
end

return M