return {
	-- Mason: LSP installer
	{
		"williamboman/mason.nvim",
		opts = {},
		config = function()
			require("mason").setup({
				-- Optional configuration options
				ensure_installed = { "" }, -- add more lsp server if you want more language
				automatic_installation = true,
			})
		end,
	},

	-- Mason-lspconfig: Bridge between mason and lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			automatic_installation = true,
		},
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			-- Setup clangd with Chromium defaults
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = function(client, bufnr)
					-- Enable inlay hints for type hints
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
			})
			vim.lsp.config("emmylua_ls", {
				-- Make the server aware of Neovim runtime files
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			vim.lsp.enable("clangd")
			vim.lsp.enable("emmylua_ls")
			-- Keymaps for LSP features
			local opts = {  noremap = true, silent = true }
			local wk = require("which-key")
			wk.add({
				{ "gd", vim.lsp.buf.definition, opts, desc = "Go to definition" },
				{ "gD", vim.lsp.buf.declaration, opts, desc = "Go to declaration" },
				{ "gi", vim.lsp.buf.implementation, opts, desc = "Go to impl" },
				{ "gr", vim.lsp.buf.references, opts, desc = "Go to refs" },
				{ "<leader>K", vim.lsp.buf.hover, opts },
				{ "<C-k>", vim.lsp.buf.signature_help, opts, desc = "Signature help" },
				{ "<leader>rn", vim.lsp.buf.rename, opts, desc = "Rename symbol" },
				{ "<leader>ca", vim.lsp.buf.code_action, opts, desc = "Code Action" },
				{
					"<leader>f",
					function()
						vim.lsp.buf.format({ async = true })
					end,
					opts,
					desc = "Format code",
				},
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
