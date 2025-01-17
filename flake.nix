/*
  * SPDX-FileCopyrightText: 2024 Name <lasagna@garfunkle.space>
  *
  * SPDX-License-Identifier: MPL-2.0
*/

{
  description = "Nvame: My personal Neovim flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    {
      packages =
        nixpkgs.lib.genAttrs
          [
            "x86_64-linux"
            "aarch64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
          ]
          (
            system:
            let
              lib = nixpkgs.lib;
              pkgs = nixpkgs.legacyPackages.${system};

              # Defines the plugins
              plugins = with pkgs.vimPlugins; [
                # Telescope
                plenary-nvim
                telescope-nvim
                telescope-file-browser-nvim
                telescope-ui-select-nvim

                # Helpers
                which-key-nvim
                todo-comments-nvim

                # Greeter
                alpha-nvim

                # Themeing
                catppuccin-nvim
                rainbow-delimiters-nvim

                # Treesitter
                nvim-treesitter.withAllGrammars

                nvim-treesitter-parsers.nix
                nvim-treesitter-parsers.lua
                nvim-treesitter-parsers.rust
                nvim-treesitter-parsers.html
                nvim-treesitter-parsers.css
                nvim-treesitter-parsers.javascript
                nvim-treesitter-parsers.typescript
                nvim-treesitter-parsers.json
                nvim-treesitter-parsers.toml
                nvim-treesitter-parsers.markdown

                # Git
                vim-fugitive
                gitsigns-nvim
                cmp-git

                # LSP
                nvim-lspconfig
                cmp-nvim-lsp

                # Snippets
                luasnip
                friendly-snippets

                # Completions
                nvim-cmp
                cmp-buffer
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
                ltex-ls # LaTeX

                # Formatting
                nixfmt-rfc-style
              ];
            in
            {
              default = self.packages.${system}.mainConfig;

              # Joins the plugin derivations and the Neovim derivation into one
              mainConfig = pkgs.symlinkJoin {
                name = "nvim";
                paths = [
                  pkgs.neovim-unwrapped
                  plugins
                  packages
                ];
                nativeBuildInputs = [ pkgs.makeWrapper ];
                postBuild = ''
                  # HACK: Since we cannot just import our config files normally, we must add them to the plugins location and have them loaded as plugins.
                  # This will work as normal however :3
                  mkdir -p $out/plugin/config/
                  ln -s ${./config}/* $out/plugin/config/

                  # Wraps Neovim and makes it use the packages in the Nix store
                  wrapProgram $out/bin/nvim \
                    --add-flags '-u' \
                    --add-flags 'NORC' \
                    --add-flags '--cmd' \
                    --add-flags "'set packpath^=$out/ | set runtimepath^=$out/,$out/after/'" \
                    --set-default NVIM_APPNAME nvame
                '';

                # This ensures our package is licensed properly within Nix
                meta = {
                  description = "My main Neovim configuration";
                  homepage = "https://git.garfunkles.space/nvame";
                  license = lib.licenses.mpl20;
                  maintainers = with lib.maintainers; [ "Name" ];
                  platforms = lib.platforms.all;
                };
              };
            }
          );

      # Creates a devShell for use in Nix Direnv
      devShells =
        nixpkgs.lib.genAttrs
          [
            "x86_64-linux"
            "aarch64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
          ]
          (
            system:
            let
              pkgs = nixpkgs.legacyPackages.${system};
            in
            {
              default = pkgs.mkShell {
                nativeBuildInputs = with pkgs; [
                  reuse
                  (self.packages.${system}.default)
                ];

                shellHook = ''echo "You have now entered the dev-shell for Nvame. Please be sure to check for REUSE compliance."'';
              };

            }
          );
    };
}
