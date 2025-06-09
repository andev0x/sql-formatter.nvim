-- author: anvndev
-- https://github.com/andev0x/sql-formatter.nvim
-- SQL Formatter Autocommands

local M = {}
local formatter = require("sql-formatter.formatter")

M.config = {}

function M.setup(config)
  M.config = config
  M.create_autocmds()
end

function M.create_autocmds()
  local group = vim.api.nvim_create_augroup("SQLFormatter", { clear = true })

  -- Format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = M.get_pattern(),
    callback = function(args)
      if M.should_format_on_save(args.buf) then
        formatter.format_buffer()
      end
    end,
    desc = "Format SQL on save",
  })

  -- Set up buffer-local settings for SQL files
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = table.concat(M.config.filetypes, ","),
    callback = function(args)
      vim.api.nvim_buf_set_option(args.buf, "commentstring", "-- %s")
    end,
    desc = "Set up SQL buffer settings",
  })
end

function M.get_pattern()
  local patterns = {}
  for _, ft in ipairs(M.config.filetypes) do
    table.insert(patterns, "*." .. ft)
  end
  return patterns
end

function M.should_format_on_save(buf)
  local buf_setting = vim.b[buf].sql_format_on_save
  if buf_setting ~= nil then
    return buf_setting
  end
  return M.config.format_on_save
end

return M
