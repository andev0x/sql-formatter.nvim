-- author: anvndev
-- https://github.com/andev0x/sql-formatter.nvim
-- SQL Formatter Plugin Initialization

local M = {}

-- Default configuration
local default_config = {
  format_on_save = true,
  dialect = "postgresql",
  indent = "  ",
  tab_width = 2,
  use_tabs = false,
  uppercase = true,
  identifier_case = "lower",
  function_case = "upper",
  datatype_case = "upper",
  lines_between_queries = 2,
  max_column_length = 80,
  comma_start = false,
  operator_padding = true,
  filetypes = { "sql", "mysql", "plsql", "pgsql" },
  keybindings = {
    format_buffer = "<leader>sf",
    format_selection = "<leader>ss",
    toggle_format_on_save = "<leader>st",
  },
  notify = {
    enabled = true,
    level = "info",
    timeout = 2000,
  },
  -- External formatter command (using sql-formatter or sqlparse)
  -- To use sql-formatter (Node.js):
  --   command = "sql-formatter",
  --   args = { "--config", "/path/to/.sql-formatter.json" } -- optional
  -- To use sqlparse (Python):
  --   command = "sqlformat",
  --   args = { "--reindent", "--keywords", "upper", "--identifiers", "lower", "--strip-comments", "-" }
  external_formatter = {
    enabled = true,
    command = "sql-formatter", -- or "sqlformat"
    args = {}, -- see above for examples
  }
}

-- Plugin configuration
M.config = {}

-- Setup function
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", default_config, opts or {})
  
  -- Load core modules
  require("sql-formatter.formatter").setup(M.config)
  require("sql-formatter.commands").setup(M.config)
  require("sql-formatter.autocmds").setup(M.config)
  require("sql-formatter.keybindings").setup(M.config)
  
  -- Check if external formatter is available
  if M.config.external_formatter.enabled then
    local formatter = require("sql-formatter.formatter")
    formatter.check_external_formatter()
  end
end

return M