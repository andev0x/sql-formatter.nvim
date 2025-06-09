-- .luacheckrc
std = luajit
codes = true

read_globals = {
  "vim",
}

globals = {
  "vim.g",
  "vim.b",
  "vim.w",
  "vim.t",
  "vim.v",
  "vim.env",
  "vim.api",
  "vim.ui",
  "vim.fn",
  "vim.opt",
  "vim.opt_local",
  "vim.opt_global",
  "vim.o",
  "vim.go",
  "vim.bo",
  "vim.wo",
  "vim.loop",
  "vim.lsp",
  "vim.treesitter",
  "vim.keymap",
  "vim.health",
  "vim.version",
  "vim.log",
  "vim.notify",
  "vim.schedule",
  "vim.defer_fn",
  "vim.wait",
  "vim.cmd",
  "vim.tbl_contains",
  "vim.tbl_deep_extend",
  "vim.tbl_extend",
  "vim.tbl_filter",
  "vim.tbl_map",
  "vim.split",
  "vim.trim",
  "vim.startswith",
  "vim.endswith",
  "vim.deepcopy",
  "vim.pesc",
  "vim.inspect",
}

ignore = {
  "631", -- max_line_length
  "611", -- line contains only whitespace
  "612", -- inconsistent indentation
  "613", -- line has trailing whitespace
}

exclude_files = {
  "tests/",
}

max_line_length = 100
max_string_line_length = 100
max_comment_line_length = 100
max_code_line_length = 100
max_cyclomatic_complexity = 20