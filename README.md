# NVaMe

My personal Neovim flake!

![A preview image of my Neovim config. It displays an ASCII image of Shinji sobbing on a chair along with some hotkeys and a footer saying "Stay wild, star child <3".](./preview.webp)

## Includes

### Main config (`mainConfig`)

Neovim:
- Catppuccin Mocha + rainbow-delimeters
- Treesitter setup for plenty of languages
- LSP configuration for plenty of languages
- Completions and snippets (Provided by friendly-snippets)
- Telescope setup
- A Git intergrations with fugitive and git-signs

Bonus tools:
- ripgrep for faster live grepping
- fd for faster file finding
- nixfmt-rfc-style for formatting
- LSPs for Nix, Latex + text docs and Lua

## Usage

To get started all you need is a system with Nix installed!
If you don't have Nix installed, you shouldn't be looking at this anyway.

### Adding LSPs

The actual language servers themselves aren't installed (Besides the Nix, Latex and Lua LSP's).
This is intentional as ideally you should be installing the language servers within your projects devshell.

### Temporary usage

To run it once on a file just do:
`nix run github:namescode/nvame -- file.txt`

For use in a shell just do:
`nix shell github:namescode/nvame --command $SHELL`

### Installing as a package

#### With NixOS

Firstly add `nvame.url = "github:namescode/nvame";` to your inputs; this will pull in the flake for use.

Then add `inputs.nvame.nixosModules.nvame` to your nixosSystem modules, like this:

```nix
nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
  modules = [
    ./configuration.nix
    inputs.nvame.nixosModules.nvame
  ];
};
```

Finally, you can access the packages for installation from `config.nvameConfigs`.
For example:
```nix
environment.systemPackages = with pkgs; [
  git
  hyfetch

  # Installs the main nvame config
  (config.nvameConfigs.mainConfig)
];
```

#### With home-manager

Firstly add `nvame.url = "github:namescode/nvame";` to your inputs; this will pull in the flake for use.

Then add `inputs.nvame.hmModules.nvame` to your nixosSystem modules, like this:

```nix
homeConfigurations.nixos = home-manager.lib.homeManagerConfigurations {
  modules = [
    ./home.nix
    inputs.nvame.hmModules.nvame
  ];
};
```

Finally, you can access the packages for installation from `config.nvameConfigs`.
For example:
```nix
home.packages = with pkgs; [
  git
  hyfetch

  # Installs the main nvame config
  (config.nvameConfigs.mainConfig)
];
```

#### With nix-darwin

Firstly add `nvame.url = "github:namescode/nvame";` to your inputs; this will pull in the flake for use.

Then add `inputs.nvame.darwinModules.nvame` to your darwinSystem modules, like this:

```nix
darwinConfigurations.macbook = darwin.lib.darwinSystem {
  modules = [
    ./configuration.nix
    inputs.nvame.nixosModules.nvame
  ];
};
```

Finally, you can access the packages for installation from `config.nvameConfigs`.
For example:
```nix
environment.systemPackages = with pkgs; [
  git
  hyfetch

  # Installs the main nvame config
  (config.nvameConfigs.mainConfig)
];
```

#### Without a module

Firstly add `nvame.url = "github:namescode/nvame";` to your inputs; this will pull in the flake for use.

Then, install the packages you need through `inputs.nvame.packages.${system}` (Make sure to pass `inputs` as an attribute)
For example:
```nix
environment.systemPackages = with pkgs; [
  git
  hyfetch

  # Installs the main nvame config
  (inputs.nvame.packages.${system}.mainConfig)
];
```
