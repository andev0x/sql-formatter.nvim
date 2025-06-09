-- author: anvndev
-- https://github.com/andev0x/sql-formatter.nvim
--     vim.notify("External SQL formatter '" .. cmd .. "' is available", vim.log.levels.INFO)
local M = {}
local formatter = require("sql-formatter.formatter")
local utils = require("sql-formatter.utils")

function M.setup(config)
  if not config.keybindings then
    return
  end
  
  M.setup_global_keymaps(config.keybindings)
  M.setup_buffer_keymaps(config)
end

function M.setup_global_keymaps(keybindings)
  if keybindings.format_buffer then
    vim.keymap.set("n", keybindings.format_buffer, function()
      formatter.format_buffer()
    end, { desc = "Format SQL buffer", silent = true })
  end
  
  if keybindings.format_selection then
    vim.keymap.set("v", keybindings.format_selection, function()
      local start_line, end_line = utils.get_visual_selection()
      formatter.format_range(start_line, end_line)
    end, { desc = "Format SQL selection", silent = true })
  end
  
  if keybindings.toggle_format_on_save then
    vim.keymap.set("n", keybindings.toggle_format_on_save, function()
      require("sql-formatter.commands").toggle_format_on_save()
    end, { desc = "Toggle SQL format on save", silent = true })
  end
end

function M.setup_buffer_keymaps(config)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = table.concat(config.filetypes, ","),
    callback = function(args)
      local opts = { buffer = args.buf, silent = true }
      
      if config.keybindings.format_buffer then
        vim.keymap.set("n", config.keybindings.format_buffer, function()
          formatter.format_buffer()
        end, vim.tbl_extend("force", opts, { desc = "Format SQL buffer" }))
      end
    end,
  })
end

return M