# Dotfiles

![Dotfiles screenshot on macOS](RiceScreenshot.png)

## Usage

### Linux

Install Nix:

```bash

```

### macOS

Install Xcode:

```bash
xcode-select --install
```

Install Brew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Nix:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

Then run:

```bash
git clone https://github.com/NamesCode/.Dotfiles.git
cd ./.Dotfiles
echo '{ configs = configs/macos.nix; username = "'$(whoami)'"; }' > machine.nix
nix --extra-experimental-features nix-command --extra-experimental-features flakes build .\#darwinConfigurations.NamesM2.system
./result/sw/bin/darwin-rebuild switch --flake .#NamesM2
```

To build again in future. CD into the directory and run:

```bash
git pull
nix build .\#darwinConfigurations.NamesM2.system
./result/sw/bin/darwin-rebuild switch --flake .#NamesM2
```
