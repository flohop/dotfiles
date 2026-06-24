mkcd() {
  if [ -z "${1:-}" ]; then
    echo "usage: mkcd DIR" >&2
    return 2
  fi

  mkdir -p "$1" && cd "$1"
}

gclonecd() {
  if [ -z "${1:-}" ]; then
    echo "usage: gclonecd URL" >&2
    return 2
  fi

  git clone "$1"
  repo_name="${1##*/}"
  repo_name="${repo_name%.git}"
  cd "$repo_name"
}

killport() {
  if [ -z "${1:-}" ]; then
    echo "usage: killport PORT" >&2
    return 2
  fi

  pids="$(lsof -tiTCP:"$1" -sTCP:LISTEN)"
  if [ -z "$pids" ]; then
    echo "No process listening on port $1"
    return 0
  fi

  echo "$pids" | xargs kill
}
