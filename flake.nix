{
  description = "Nvame: My personal Neovim flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let system = "aarch64-linux";
  pkgs = import nixpkgs { inherit system; };
  lib = pkgs.lib;
  plugins = with pkgs.vimPlugins; [ telescope-nvim plenary-nvim vim-nix ];
  in { 
  packages.aarch64-linux.default =
     pkgs.symlinkJoin {
       name = "nvim";
       paths = [ pkgs.neovim-unwrapped plugins ];
       nativeBuildInputs = [ pkgs.makeWrapper ];
       postBuild = ''
         wrapProgram $out/bin/nvim \
           --add-flags '-u' \
           --add-flags '${./config/init.lua}' \
           --add-flags '--cmd' \
	   --add-flags "'set packpath^=$out/ | set runtimepath^=$out/'"
       '';
     };
  };
}
