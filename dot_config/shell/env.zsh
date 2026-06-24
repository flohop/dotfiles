export EDITOR="nvim"
export VISUAL="code"
export PAGER="less"

path_prepend() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}

path_prepend "/opt/homebrew/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/.local/bin"

export PATH
