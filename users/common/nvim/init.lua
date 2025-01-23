vim.g.mapleader = " "
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.lang" },
		{ import = "nixos-overlay" },
	},
})
