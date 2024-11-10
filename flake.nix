{
  description = "Nvame: My personal Neovim flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "aarch64-linux";
    pkgs = import nixpkgs {inherit system;};

    # Defines the plugins
    plugins = with pkgs.vimPlugins; [
      # Telescope
      plenary-nvim
      telescope-nvim
      telescope-file-browser-nvim
      telescope-ui-select-nvim

      # Helpers
      which-key-nvim

      # Themeing
      catppuccin-nvim
      rainbow-delimiters-nvim

      # Treesitter
      nvim-treesitter.withAllGrammars
      
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.rust
      nvim-treesitter-parsers.html
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.toml
      nvim-treesitter-parsers.markdown

      # LSP
      nvim-lspconfig
      cmp-nvim-lsp

      # Snippets
      luasnip
      friendly-snippets

      # Completions
      nvim-cmp
      cmp-buffer
      cmp-git
      cmp_luasnip
      SchemaStore-nvim
    ];

    # Defines the external packages required
    packages = with pkgs; [
      # Better grep
      ripgrep
      
      # Better file finding
      fd

      # LSP servers
      nil # Nix
      sumneko-lua-language-server # Lua
    ];
  in {
    # Joins the plugin derivations and the Neovim derivation into one
    packages.aarch64-linux.default = pkgs.symlinkJoin {
      name = "nvim";
      paths = [pkgs.neovim-unwrapped plugins packages ];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        # Wraps Neovim and makes it use the packages in the Nix store
        wrapProgram $out/bin/nvim \
          --add-flags '-u' \
          --add-flags '${./config}/init.lua'\
          --add-flags '--cmd' \
          --add-flags "'set packpath^=$out/ | set runtimepath^=$out/'"
      '';
    };
  };
}
