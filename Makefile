# Makefile for nvim-sql-formatter

.PHONY: install test lint clean format check-deps

# Installation
install:
	@echo "Installing development dependencies..."
	@command -v luacheck >/dev/null 2>&1 || { echo "Installing luacheck..."; luarocks install luacheck; }
	@command -v stylua >/dev/null 2>&1 || { echo "Installing stylua..."; cargo install stylua; }

# Testing
test:
	@echo "Running tests..."
	@nvim --headless -c "lua require('plenary.test_harness').test_directory('tests')" -c "qa!"

# Linting
lint:
	@echo "Running luacheck..."
	@luacheck lua/ --globals vim

# Formatting
format:
	@echo "Formatting Lua files..."
	@stylua lua/

# Check dependencies
check-deps:
	@echo "Checking dependencies..."
	@command -v nvim >/dev/null 2>&1 || { echo "Neovim not found"; exit 1; }
	@nvim --version | head -1
	@command -v sqlformat >/dev/null 2>&1 && echo "sqlparse: Available" || echo "sqlparse: Not available (install with: pip install sqlparse)"

# Clean
clean:
	@echo "Cleaning temporary files..."
	@find . -name "*.tmp" -delete
	@find . -name ".DS_Store" -delete

# Development setup
dev-setup: install check-deps
	@echo "Development environment ready!"