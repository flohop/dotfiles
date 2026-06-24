# dotfiles

Practical macOS developer bootstrap using chezmoi, Homebrew Bundle, and a small install script.

## What This Does

- Installs Homebrew if it is missing.
- Installs chezmoi if it is missing.
- Applies these dotfiles with chezmoi.
- Installs CLI tools and apps from `Brewfile`.
- Optionally applies a few safe macOS defaults.

The setup is intentionally small, readable, and safe to run more than once.

## Prerequisites

- macOS
- Command Line Tools for Xcode
- Internet access for Homebrew and package installs

Install Command Line Tools if needed:

```sh
xcode-select --install
```

## First-Time Install

Clone the repo, then run:

```sh
cd dotfiles
./install.sh
```

For a remote GitHub repo, the first install usually looks like:

```sh
git clone git@github.com:flohop/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Safer Manual Install

If you want to inspect each step first:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi
chezmoi apply --source="$HOME/dotfiles"
brew bundle --file="$HOME/dotfiles/Brewfile"
./scripts/configure-macos.sh
```

## Adding Dotfiles

Use chezmoi to add files from your home directory:

```sh
chezmoi add ~/.zshrc
chezmoi add ~/.config/nvim/init.lua
chezmoi cd
git status
```

Edit tracked files with:

```sh
chezmoi edit ~/.zshrc
chezmoi apply
```

If you edit the real file directly on a laptop, copy that change back into the repo before committing:

```sh
chezmoi re-add ~/.zshrc
chezmoi cd
git status
git add .
git commit -m "Update zsh config"
git push
```

Repeat `chezmoi re-add` for any changed file you want to transfer to other machines.

## Updating Later

Pull repo changes and apply:

```sh
cd ~/dotfiles
git pull
./install.sh
```

Install or update apps from the Brewfile:

```sh
brew bundle --file="$HOME/dotfiles/Brewfile"
```

## Secrets Warning

Do not commit secrets, SSH private keys, tokens, `.env` files, API keys, credentials, or machine-specific private paths. Keep those in a password manager or a local-only secrets system.
