# sql-formatter.nvim

A lightweight, high-performance SQL formatter plugin for Neovim that leverages `sqlparse` for optimal formatting results with a Lua fallback for basic formatting.

## Images
<p float="left">
  <img src="https://raw.githubusercontent.com/andev0x/description-image-archive/refs/heads/main/sql-formatter/p1.png" width="300" />
  <img src="https://raw.githubusercontent.com/andev0x/description-image-archive/refs/heads/main/sql-formatter/p2.png" width="300" />
</p>

## Features

- 🚀 **High Performance**: Uses external `sqlparse` formatter for speed
- 🔧 **Configurable**: Extensive customization options
- 📝 **Format on Save**: Automatic formatting when saving files
- ⌨️ **Key Bindings**: Convenient shortcuts for formatting
- 🎯 **Multi-dialect**: Support for PostgreSQL, MySQL, SQLite, and more
- 🔄 **Fallback**: Pure Lua formatter when external tools unavailable
- 📋 **Range Formatting**: Format selected text only

## Requirements

- Neovim >= 0.8.0
- Optional: `sqlparse` for optimal performance (`pip install sqlparse`)

## Installation

### Prerequisites

For optimal performance, install `sqlparse`:

```bash
pip install sqlparse
```

### Plugin Installation

#### lazy.nvim

```lua
{
"andev0x/sql-formatter.nvim",
ft = { "sql", "mysql", "plsql", "pgsql" },
config = function()
  vim.g.sqlformat_command = "sqlformat"
  vim.g.sqlformat_options = "-r -k upper"
  vim.g.sqlformat_prog = "sqlformat"
end,
},
```

#### packer.nvim

```lua
use {
  "andev0x/sql-formatter.nvim",
  ft = { "sql", "mysql", "plsql", "pgsql" },
  config = function()
    require("sql-formatter").setup()
  end,
}
```

#### vim-plug

```vim
Plug 'andev0x/sql-formatter.nvim'
```

## Configuration

### Minimal Setup

```lua
require("sql-formatter").setup()
```

### Full Configuration

```lua
require("sql-formatter").setup({
  -- Core settings
  format_on_save = true,
  dialect = "postgresql",
  
  -- Indentation
  indent = "  ",
  tab_width = 2,
  use_tabs = false,
  
  -- Case formatting
  uppercase = true,
  identifier_case = "lower",
  function_case = "upper",
  datatype_case = "upper",
  
  -- Layout
  lines_between_queries = 2,
  max_column_length = 80,
  comma_start = false,
  operator_padding = true,
  
  -- File types
  filetypes = { "sql", "mysql", "plsql", "pgsql" },
  
  -- Key bindings
  keybindings = {
    format_buffer = "<leader>sf",
    format_selection = "<leader>ss",
    toggle_format_on_save = "<leader>st",
  },
  
  -- External formatter (sqlparse)
  external_formatter = {
    enabled = true,
    command = "sqlformat",
    args = {
      "--reindent",
      "--keywords", "upper",
      "--identifiers", "lower",
      "--strip-comments",
      "-"
    }
  },
  
  -- Notifications
  notify = {
    enabled = true,
    level = "info",
    timeout = 2000,
  },
})
```

## Usage

### Commands

- `:SQLFormat` - Format entire buffer
- `:SQLFormatRange` - Format selected lines (visual mode)
- `:SQLFormatToggle` - Toggle format-on-save for current buffer
- `:SQLFormatInfo` - Show formatter information

### Key Bindings (default)

- `<leader>sf` - Format buffer
- `<leader>ss` - Format selection (visual mode)
- `<leader>st` - Toggle format-on-save

### Example

**Before:**
```sql
select u.id,u.name,p.title from users u left join posts p on u.id=p.user_id where u.active=1 and p.published=true order by u.created_at desc;
```

**After:**
```sql
SELECT
    u.id,
    u.name,
    p.title
FROM users u
LEFT JOIN posts p
    ON u.id = p.user_id
WHERE u.active = 1
    AND p.published = TRUE
ORDER BY u.created_at DESC;
```

## Performance

This plugin prioritizes performance by:

1. **External Formatter**: Uses `sqlparse` (Python) for heavy lifting
2. **Lua Fallback**: Lightweight Lua formatter when external tools unavailable
3. **Lazy Loading**: Only loads for SQL file types
4. **Minimal Dependencies**: Pure Lua implementation with optional external tools

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Author

**anvndev** ([@andev0x](https://github.com/andev0x))

## Support

If you find this plugin useful, consider [sponsoring the development](https://github.com/sponsors/andev0x).