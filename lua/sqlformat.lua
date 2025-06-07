-- Author: anvndev
-- File: lua/sqlformat.lua
local M = {}

local defaults = {
	indent = 2,
	keyword_case = 'upper',
	line_width = 80,
	format_on_save = false,
	custom_keymaps = {
		format = '<leader>sf'
	}
}

M.setup = function(opts)
	opts = vim.tbl_deep_extend('force', defaults, opts or {})
	
	-- Set global variables for VimScript
	vim.g.sqlformat_indent = opts.indent
	vim.g.sqlformat_keyword_case = opts.keyword_case
	vim.g.sqlformat_line_width = opts.line_width
	vim.g.sqlformat_format_on_save = opts.format_on_save
	
	-- Set up custom keymaps
	if opts.custom_keymaps then
		vim.keymap.set('n', opts.custom_keymaps.format, ':SQLFormat<CR>', { 
			silent = true,
			desc = 'Format SQL code'
		})
	end
end

return M
