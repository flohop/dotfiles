# dotfiles

macOS developer bootstrap using chezmoi, Homebrew Bundle, and a single install script.

## New Laptop Setup

1. Install Xcode Command Line Tools:

```sh
xcode-select --install
```

2. Clone and install:

```sh
git clone git@github.com:flohop/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

This will:
- Install Homebrew (if missing)
- Install chezmoi (if missing)
- Apply all dotfiles via chezmoi (`~/.zshrc`, `~/.tmux.conf`, `~/.config/`, `~/bin/`, etc.)
- Install all CLI tools and apps from `Brewfile`
- Apply macOS defaults

3. Restart your terminal.

## Day-to-Day Usage

### Adding a new dotfile

```sh
chezmoi add ~/.some-config
cd ~/dotfiles && git add -A && git commit -m "Add some-config" && git push
```

### Editing a tracked dotfile

Edit the real file, then sync back:

```sh
chezmoi re-add ~/.zshrc
cd ~/dotfiles && git add -A && git commit -m "Update zshrc" && git push
```

### Pulling changes on another machine

```sh
cd ~/dotfiles
git pull
chezmoi apply --source="$HOME/dotfiles"
```

Or re-run `./install.sh` to also update Homebrew packages.

### Adding a new brew package

```sh
brew install <package>
# Add it to Brewfile, then commit
```

## Secrets Warning

Do not commit SSH keys, tokens, `.env` files, API keys, or credentials. Keep those in a password manager.
