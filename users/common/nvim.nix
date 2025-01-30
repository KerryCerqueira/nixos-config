{ pkgs, config, flakeInputs, ... }:

let
	nvimPlgDirs = config.programs.neovim.finalPackage.passthru.packpathDirs;
	nvimPackDir = pkgs.vimUtils.packDir nvimPlgDirs;
in {
	# home.file.".local/share/nvim/lazy" = {
	# 	source = "${nvimPackDir}/pack/myNeovimPackages/start";
	# 	recursive = true;
	# };

	# If you are not seeing any search results, you may need to run manix
	# --update-cache <query>, to initialise the cache.
	home.packages = with pkgs; [
		manix
		lynx
		texlive.combined.scheme-basic
	];
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
			lua-language-server
			jdt-language-server
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
			CopilotChat-nvim
			copilot-cmp
			copilot-lua
			copilot-lualine
			diffview-nvim
			edgy-nvim
			friendly-snippets
			gitsigns-nvim
			image-nvim
			lazy-nvim
			lazydev-nvim
			lualine-nvim
			lualine-lsp-progress
			telescope-frecency-nvim
			telescope-symbols-nvim
			telescope-manix
			telescope-nvim
			telescope-symbols-nvim
			telescope-undo-nvim
			telescope-zf-native-nvim
			trouble-nvim
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
			snacks-nvim
			vimtex
			which-key-nvim
			yazi-nvim
		];
		extraLuaConfig = let
			nvimStorePaths = config.programs.neovim.finalPackage.passthru.packpathDirs;
			nvimPkgsPath = pkgs.vimUtils.packDir nvimStorePaths;
		in
			# lua
			''
vim.g.mapleader = " "
vim.g.maplocalleader = ","
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.lang" },
		{ import = "nixos-overlay" },
		{
			"folke/lazydev.nvim",
			opts = {
				library = { "${nvimPackDir}/pack/myNeovimPackages/start" },
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
