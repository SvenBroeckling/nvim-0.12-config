-- vim:fileencoding=utf-8:foldmethod=marker

-- [[ --------------------- KEYMAP OVERVIEW --------------------- ]]
--
-- Leader key: "," (comma)
--
-- ---------------------------------------------------------------
--  General Editor & Text
-- ---------------------------------------------------------------
--   <leader>w    (n) : Toggle word wrap ON
--   <leader>W    (n) : Toggle word wrap OFF
--   Y            (n) : Yank line (full line)
--   <C-c>        (n) : Copy current line to clipboard
--   <C-c>        (v) : Copy selection to clipboard
--   >            (v) : Indent selection
--   <            (v) : Outdent selection
--
-- ---------------------------------------------------------------
--  Window & Buffer Management
-- ---------------------------------------------------------------
--   <C-h>        (n) : Move window to far left
--   <C-l>        (n) : Move window to far right
--   gt           (n) : Go to next buffer
--   gT           (n) : Go to previous buffer
--   gb           (n) : [Telescope] Go to buffer
--   <leader>sb   (n) : [Telescope] Search buffers
--
-- ---------------------------------------------------------------
--  File & Project Navigation
-- ---------------------------------------------------------------
--   <C-n>        (n) : Toggle NvimTree file explorer
--   <M-1>        (n) : Open Oil file explorer
--   <M-2>        (n) : Open MiniFiles file explorer
--   <C-p>        (n) : [Telescope] Find files
--   <C-e>        (n) : [Telescope] Find old files (history)
--
-- ---------------------------------------------------------------
--  Telescope (Search)
-- ---------------------------------------------------------------
--   <leader>sg   (n) : Live Grep (search project text)
--   <leader>sw   (n) : Grep for word under cursor
--   <leader>sf   (n) : Search Functions (LSP)
--   <leader>sc   (n) : Search Classes (LSP)
--   <leader>sv   (n) : Search Variables (LSP)
--   <leader>ss   (n) : Search All Symbols (LSP)
--   <leader>sh   (n) : Search help tags
--   <leader>sk   (n) : Search keymaps
--
-- ---------------------------------------------------------------
--  LSP & Code (Active in code buffers)
-- ---------------------------------------------------------------
--   gd           (n) : Go to Definition
--   K            (n) : Hover documentation
--   [d           (n) : Go to previous diagnostic
--   ]d           (n) : Go to next diagnostic
--   <leader>ca   (n) : Code Actions
--   <leader>rn   (n) : Rename symbol
--   <leader>vr   (n) : View References
--   <leader>vws  (n) : View Workspace Symbols
--   <leader>lf   (n) : Format buffer (LSP)
--   <C-h>        (i) : Signature Help (in insert mode)
--
-- ---------------------------------------------------------------
--  Diagnostics & Quickfix
-- ---------------------------------------------------------------
--   <leader>ge   (n) : Jump to next diagnostic
--   <leader>gE   (n) : Jump to previous diagnostic
--   <leader>vd   (n) : Show diagnostic in float
--   <leader>sd   (n) : [Telescope] Search all diagnostics
--   <leader>x    (n) : Close quickfix window
--   <leader>sn   (n) : Next item in quickfix
--   <leader>sp   (n) : Previous item in quickfix
--   <leader>sq   (n) : [Telescope] Search quickfix list
--
-- ---------------------------------------------------------------
--  Bookmarks (bookmarks.nvim)
-- ---------------------------------------------------------------
--   <leader>ba   (n) : Add bookmark at line
--   <leader>br   (n) : Remove bookmark at line
--   <leader>bl   (n) : [Telescope] List all bookmarks
--   mn           (n) : Jump to next bookmark (plugin default)
--   mp           (n) : Jump to previous bookmark (plugin default)
--
-- [[ ----------------------------------------------------------- ]]

--: Options
vim.g.mapleader = ","
vim.o.background = "dark"
vim.o.backup = false
vim.o.expandtab = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.updatetime = 50
vim.o.winborder = "rounded"
vim.o.wrap = false
--:

--: Godot
-- paths to check for project.godot file
local paths_to_check = { '/', '/../' }
local is_godot_project = false
local godot_project_path = ''
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
	if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
		is_godot_project = true
		godot_project_path = cwd .. value
		break
	end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. '/server.pipe')
-- start server, if not already running
if is_godot_project and not is_server_running then
	vim.fn.serverstart(godot_project_path .. '/server.pipe')
end
--:

--: Basic keymaps
local function set_wrap()
	vim.opt.wrap = true
	vim.opt.linebreak = true
	vim.keymap.set('n', 'j', 'gj')
	vim.keymap.set('n', 'k', 'gk')
end

local function set_nowrap()
	vim.opt.wrap = false
	vim.opt.linebreak = false
	vim.keymap.set('n', 'j', 'j')
	vim.keymap.set('n', 'k', 'k')
end

vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })

vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('v', '<C-c>', '"+y')
vim.api.nvim_set_keymap("n", "<C-c>", [[:lua vim.fn.setreg('+', vim.fn.getline('.'))<CR>]],
	{ noremap = true, silent = true })

vim.keymap.set('n', '<leader>w', set_wrap)
vim.keymap.set('n', '<leader>W', set_nowrap)

vim.keymap.set('n', '<leader>x', [[:cclose]])

vim.keymap.set("n", "<leader>ge", function() vim.diagnostic.jump({ count = 1 }) end)
vim.keymap.set("n", "<leader>gE", function() vim.diagnostic.jump({ count = -1 }) end)

vim.keymap.set("n", "<leader>sn", ":cnext<CR>", { noremap = true })
vim.keymap.set("n", "<leader>sp", ":cprev<CR>", { noremap = true })

-- Move the current window to the far left
vim.keymap.set('n', '<C-h>', '<C-W>H', { desc = 'Move window to far left', noremap = true, silent = true })
-- Move the current window to the far right
vim.keymap.set('n', '<C-l>', '<C-W>L', { desc = 'Move window to far right', noremap = true, silent = true })

vim.keymap.set('n', 'gt', ':bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gT', ':bp<CR>', { noremap = true, silent = true })
--:

--: Plugins

--: catppuccin
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim.git", name = "catppuccin" },
})
vim.cmd.colorscheme "catppuccin"
--:

--: sleuth
vim.pack.add({
	{ src = "https://github.com/tpope/vim-sleuth" },
})
--:

--: nvim-notify
vim.pack.add({
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/folke/noice.nvim" },
})
require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	presets = {
		bottom_search = true,   -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false,     -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})
--:

--: treesitter
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require('nvim-treesitter.configs').setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "javascript", "typescript", "python", "c", "lua", "vim", "vimdoc", "query", "htmldjango", "gdscript", "godot_resource", "gdshader" },
	sync_install = false,
	auto_install = true,
	ignore_install = {},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
--:

--: lsp and mason
vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
})
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "basedpyright", "rust_analyzer", "emmet_ls", "eslint", "ts_ls", "tailwindcss" },
})

--vim.lsp.enable({ "lua_ls", "basedpyright", "rust_analyzer", "djlsp", "gdscript" })

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action({
			filter = function(action)
				return not action.disabled
			end,
		})
	end, opts)
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
end

vim.lsp.config("djlsp", { on_attach = on_attach })
vim.lsp.config("eslint", { on_attach = on_attach })
vim.lsp.config("ts_ls", { on_attach = on_attach })
vim.lsp.config("tailwindcss", { on_attach = on_attach })

vim.lsp.config("basedpyright", {
	on_attach = on_attach,
	root_dir = require("lspconfig.util").root_pattern(".git", "setup.py", "pyproject.toml", "requirements.txt"),
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = 'basic'
			},
		},
	},
})

vim.lsp.config("emmet_ls", {
	on_attach = on_attach,
	filetypes = { "htmldjango", "djangohtml", "html" },
})

vim.lsp.config("lua_ls", { on_attach = on_attach })
vim.lsp.config("rust_analyzer", { on_attach = on_attach })

--:

--: nvim-tree
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
require("nvim-tree").setup({
	view = {
		adaptive_size = true,
	},
	update_focused_file = {
		enable = true,
	},
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
})
--:

--: blink.cmp
vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" },
})
require("blink.cmp").setup({
	keymap = { preset = 'default' },
	appearance = {
		nerd_font_variant = 'mono'
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	fuzzy = { implementation = "prefer_rust" }
})
--:

--: telescope
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local builtin = require('telescope.builtin')

require('telescope').setup({
	pickers = {
		buffers = {
			initial_mode = "normal",
		},
		bookmarks = {
			initial_mode = "normal",
		},
	},
})

function SearchClasses()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Class" },
		prompt_title = "Search Classes"
	})
end

function SearchFunctions()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Function", "Method" },
		prompt_title = "Search Functions"
	})
end

function SearchVariables()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Variable", "Constant" },
		prompt_title = "Search Variables"
	})
end

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-e>', builtin.oldfiles, {})
-- vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
vim.keymap.set('n', '<leader>sf', SearchFunctions, {})
vim.keymap.set('n', '<leader>sc', SearchClasses, {})
vim.keymap.set('n', '<leader>sv', SearchVariables, {})
vim.keymap.set('n', 'gb', ":Telescope buffers<CR>", { desc = '[G]oto [B]uffer' })
vim.keymap.set('n', '<leader>ss', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>sq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>sk', builtin.keymaps, {})
--:

--: supermaven
vim.pack.add({
	{ src = "https://github.com/supermaven-inc/supermaven-nvim" },
})
require("supermaven-nvim").setup({})
--:

--: conform
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})
require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		json = { "jq" },
		rust = { "rustfmt" },
		python = { "black" },
		htmldjango = { "djlint" },
		html = { "djlint" },
		javascript = { "prettier" },
	},
})
--:

--: lualine
vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require('lualine').setup({
	options = {
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			{
				'branch',
				fmt = function(str)
					if #str > 5 then
						return str:sub(1, 5) .. '…'
					end
					return str
				end
			},
			'diff'
		},
		lualine_c = {
			{
				'filename',
				path = 1,
				file_status = true,
				fmt = function(str)
					local sep = package.config:sub(1, 1) -- Get OS-specific path separator ('/' or '\')
					local parts = {}

					for part in string.gmatch(str, "([^" .. sep .. "]+)") do
						table.insert(parts, part)
					end

					-- If there's only one part (the filename), just return it
					if #parts == 1 then
						return parts[1]
					end

					local result = {}
					-- Process all parts except the last one
					for i = 1, #parts - 1 do
						-- Take the first character of the directory name
						table.insert(result, parts[i]:sub(1, 1))
					end

					-- Add the full filename (the last part)
					table.insert(result, parts[#parts])

					-- Join them all back together
					return table.concat(result, sep)
				end,
			}
		},
		lualine_x = { 'diagnostics', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	tabline = {
		--lualine_a = { 'tabs' }
	},
	inactive_sections = {
		lualine_c = { { 'filename', path = 1, file_status = true } },
	},
	extensions = {}
})
--:

--: mini files
vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.files" },
})
require('mini.files').setup()
vim.keymap.set('n', '<M-2>', ":lua MiniFiles.open()<cr>", {})


--: oil
vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim.git" },
})
require('oil').setup()
vim.keymap.set('n', '<M-1>', "<CMD>Oil<CR>", {})


--: diffview
vim.pack.add({
	{ src = "https://github.com/sindrets/diffview.nvim" },
})


--: tiny-inline-diagnostic
vim.pack.add({
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
})
require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({
	virtual_text = false,
	jump = { float = true },
})

--: bufferline
vim.pack.add({
	{ src = "https://github.com/akinsho/nvim-bufferline.lua" },
	-- Optional, but recommended for file icons
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("bufferline").setup({
	options = {
		mode = "buffers",
		separator_style = "thin",
		show_buffer_close_icons = true,
		show_close_icon = true,
	}
})
--:

--: bookmarks
vim.pack.add({
	{ src = "https://github.com/heilgar/bookmarks.nvim" },
	{ src = "https://github.com/kkharji/sqlite.lua" },
})

require("bookmarks").setup({
	default_mappings = true,
	db_path = vim.fn.stdpath('data') .. '/bookmarks.db'
})

pcall(require("telescope").load_extension, "bookmarks")

vim.keymap.set('n', '<leader>ba', "<cmd>BookmarkAdd<cr>", { desc = "Add Bookmark", noremap = true, silent = true })
vim.keymap.set('n', '<leader>br', "<cmd>BookmarkRemove<cr>", { desc = "Remove Bookmark", noremap = true, silent = true })
vim.keymap.set('n', '<leader>bl', "<cmd>Bookmarks<cr>",
	{ desc = "List Bookmarks (Telescope)", noremap = true, silent = true })
--:
