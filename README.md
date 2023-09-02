# Nix configurations

## Folder structure

```
├── flake.nix      + Top level configuration
│
├── home           + Platform-independent
│  ├── default.nix   configuration using
│  ├── git.nix       home-manager
│  ├── shell.nix
│  └── ...
├── hosts          + Machine specific configuration
│  ├── charon
│  ├── hygiea
│  └── io
└── kernels        # Configuration that's shared
   ├── darwin        amongst devices of the same platform
   └── linux
```
