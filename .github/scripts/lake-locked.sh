#!/bin/sh
# The `lake` the authoritative workflow hands to the checker (through PEQUALNP_REAL_LAKE, the
# place tools/bin/lake reads the real lake from). The checker itself is not changed.
#
# `lake build` is the one command that compiles the proof file, and a Lean file can run code
# while it compiles. So every build runs as the account `outsider`: no network, an empty
# environment, no way to gain privileges, and write access to nothing but the output
# directories of its own module. Every other lake command (the verifier's run) is the plain
# pinned lake, run by the workflow's own account, which that compile cannot touch.
set -eu
: "${PNP_TC_BIN:?the toolchain bin directory}" "${PNP_GITCONFIG:?the git config file}"
case "${1:-}" in
  build)
    code=0
    sudo -n unshare --net -- setpriv --reuid=outsider --regid=outsider --init-groups --no-new-privs \
      env -i HOME=/home/outsider LANG=C.UTF-8 PATH="$PNP_TC_BIN:/usr/bin:/bin" \
        LAKE_ARTIFACT_CACHE=false LEAN_NUM_THREADS="${LEAN_NUM_THREADS:-3}" \
        GIT_CONFIG_GLOBAL="$PNP_GITCONFIG" GIT_CONFIG_NOSYSTEM=1 \
      "$PNP_TC_BIN/lake" "$@" || code=$?
    # Nothing a build started may outlive it: the compiled result is read only once it is still.
    sudo -n pkill -KILL -u outsider || true
    exit "$code" ;;
  *)
    exec "$PNP_TC_BIN/lake" "$@" ;;
esac
