# nix

> 🚧 **always WIP** - nix is a rabbit hole and continuously evolving 🔨

My NixOS, nix-darwin and home-manager config for all my machines.

It's a [flake-parts](https://flake.parts)-based flake currently set up in the
[dendritic pattern](https://github.com/mightyiam/dendritic). This means that `.nix` files (=*features*)
under `modules/` gets auto-imported by
[`vic/import-tree`](https://github.com/vic/import-tree).

## My current Hosts

| Host       | Platform         | Kind   | Role                                                                   |
| ---------- | ---------------- | ------ | ---------------------------------------------------------------------- |
| `io`       | `aarch64-darwin` | darwin | M1 MBP, main machine                                                   |
| `phoebe`   | `x86_64-linux`   | linux  | Remote workstation                                                     |
| `iapetus`  | `x86_64-linux`   | linux  | N100, main home server (Paperless, Home Assistant, coffee-vault, ...)  |
| `gonggong` | `aarch64-linux`  | linux  | Hetzner VServer, public server                                         |
| `hygiea`   | `aarch64-linux`  | linux  | Raspberry Pi 4                                                         |

## Projects this builds on

- [flake-parts](https://flake.parts) - for modular flake outputs
- [dendritic](https://github.com/mightyiam/dendritic), the file-as-module pattern this repo follows
- [home-manager](https://github.com/nix-community/home-manager) for user-level config
- [nix-darwin](https://github.com/lnl7/nix-darwin) - nix for  macOS
- [agenix](https://github.com/ryantm/agenix) + [agenix-rekey](https://github.com/oddlama/agenix-rekey) for age-encrypted secrets
- [disko](https://github.com/nix-community/disko) for declarative disk layout
- [impermanence](https://github.com/nix-community/impermanence) makes junk ephemeral
- [lanzaboote](https://github.com/nix-community/lanzaboote) for easy secure boot
- [mvim](https://github.com/mkienitz/mvim) - my custom neovim config
