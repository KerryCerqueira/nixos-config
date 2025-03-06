{ pkgs, config, flakeInputs, ... }:

let
	nvimPlgDirs = config.programs.neovim.finalPackage.passthru.packpathDirs;
	nvimPackDir = pkgs.vimUtils.packDir nvimPlgDirs;
in {
	home.file.".config/nvim/lua" = {
		source = "${flakeInputs.nvim-config}/lua";
		recursive = true;
	};
	programs.neovim = {
		enable = true;
		withRuby = true;
		withNodeJs= true;
		withPython3= true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		defaultEditor = true;
		extraLuaPackages = ps: [
			ps.tiktoken_core
		];
		extraPackages = with pkgs; [
			gh
			alejandra
			bash-language-server
			nodePackages.prettier
			shellcheck
			stylua
			taplo
			yaml-language-server
			vscode-langservers-extracted
			black
			manix
			lynx
			texlive.combined.scheme-medium
			marksman
			markdownlint-cli2
			python312Packages.pylatexenc
			python312Packages.flake8
			lua-language-server
			jdt-language-server
			fish-lsp
			taplo
			pyright
			ruff
			texlab
			nil
			flakeInputs.hyprls.packages.${system}.default
		];
		plugins = with pkgs.vimPlugins; [
			blink-cmp
			blink-cmp-copilot
			bufferline-nvim
			catppuccin-nvim
			cmp-treesitter
			cmp-vimtex
			colorful-menu-nvim
			conform-nvim
			CopilotChat-nvim
			copilot-cmp
			copilot-lua
			copilot-lualine
			crates-nvim
			diffview-nvim
			edgy-nvim
			friendly-snippets
			gitsigns-nvim
			image-nvim
			lazy-nvim
			lualine-nvim
			lualine-lsp-progress
			telescope-frecency-nvim
			telescope-manix
			telescope-nvim
			telescope-symbols-nvim
			telescope-undo-nvim
			telescope-zf-native-nvim
			trouble-nvim
			iron-nvim
			mini-ai
			mini-align
			mini-basics
			mini-bracketed
			mini-comment
			mini-icons
			mini-jump
			mini-map
			mini-move
			mini-pairs
			mini-splitjoin
			mini-surround
			mini-trailspace
			neoconf-nvim
			neodev-nvim
			neogit
			neo-tree-nvim
			nvim-cmp
			nvim-lint
			nvim-lspconfig
			nvim-treesitter.withAllGrammars
			nvim-treesitter-context
			nvim-treesitter-endwise
			nvim-treesitter-pairs
			nvim-treesitter-textobjects
			nvim-treesitter-textsubjects
			nvim-ts-context-commentstring
			nvim-web-devicons
			render-markdown-nvim
			rustaceanvim
			SchemaStore-nvim
			snacks-nvim
			vimtex
			which-key-nvim
			yazi-nvim
		];
		extraLuaConfig = # lua
''
vim.g.mapleader = " "
vim.g.maplocalleader = ","
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.lang" },
		{
			"folke/lazydev.nvim",
			optional = true,
			opts = {
				library = { "${nvimPackDir}/pack/myNeovimPackages/start" },
			},
		},
		{
			{ "williamboman/mason-lspconfig.nvim", enabled = false },
			{ "williamboman/mason.nvim", enabled = false },
		},
		{
			{
				"nvim-treesitter/nvim-treesitter",
				opts = {
					auto_install = false,
					ensure_installed = {},
				},
				build = nil
			},
		},
	},
	dev = {
		path = "${nvimPackDir}/pack/myNeovimPackages/start",
		patterns = {""},
	},
	performance = {
		reset_packpath = false,
		rtp = { reset = false, },
	},
	install = { missing = false, },
})
'';
	};
}
