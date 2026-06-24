if command -v eza >/dev/null 2>&1; then
  alias ll="eza -la --git --icons"
  alias la="eza -a --icons"
  alias lt="eza --tree --level=2 --icons"
else
  alias ll="ls -la"
  alias la="ls -A"
  alias lt="find . -maxdepth 2 -print"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi

alias vim="nvim"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gco="git checkout"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcb="docker compose build"
alias dps="docker ps"
alias ports="lsof -iTCP -sTCP:LISTEN -n -P"
