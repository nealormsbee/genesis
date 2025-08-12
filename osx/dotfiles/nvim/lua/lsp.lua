-- Lua
vim.lsp.config("luals", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
})

-- Typescript
vim.lsp.config("tsls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json" },
})

-- ESLint
vim.lsp.config("eslint", {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "typescript", "javascript", "typescriptreact" },
	root_markers = { ".eslitrc" },
})

-- Golang
vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go" },
	root_markers = { "go.mod", "go.sum" },
})

vim.lsp.enable("luals")
vim.lsp.enable("tsls")
vim.lsp.enable("eslint")
vim.lsp.enable("gopls")
