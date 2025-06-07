# nvim-sqlformat

A Neovim plugin for formatting SQL code using [sqlparse](https://github.com/andialbrecht/sqlparse).

## Features

- Format SQL code with customizable indentation
- Support for keyword case customization (upper/lower)
- Simple command and keybinding interface
- Uses the powerful sqlparse library for consistent SQL formatting

## Requirements

- Neovim
- Python 3.x
- sqlparse Python package

## Installation

1. Install the plugin with your preferred plugin manager:

   ```vim
   " vim-plug
   Plug 'andevgo/nvim-sqlformat'

   " packer.nvim
   use 'andevgo/nvim-sqlformat'

   " lazy.nvim
   {
     'andevgo/nvim-sqlformat',
     config = function()
       -- Optional: Configure plugin settings here
     end
   }
   ```

2. Install the required Python package:
   ```bash
   pip install sqlparse
   ```

## Usage

### Commands

- `:SQLFormat` - Format the entire buffer
- `:'<,'>SQLFormat` - Format selected lines in visual mode

### Keybindings

By default, the plugin provides the following keybinding:
- `<leader>sf` - Format the current buffer

## Configuration

You can customize the plugin behavior by setting these variables in your Neovim configuration:

```vim
" Set indentation size (default: 2)
let g:sqlformat_indent = 4

" Set keyword case (options: 'upper' or 'lower', default: 'upper')
let g:sqlformat_keyword_case = 'lower'
```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/andevgo/nvim-sqlformat/blob/main/LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
