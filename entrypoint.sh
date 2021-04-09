#!/usr/bin/env bash

set -eo pipefail

web-server() {
    rm -f tmp/pids/server.pid
    bin/rails server -b 0.0.0.0
}

tests() {
    bin/rails test
}

main() {
    case "$1" in
        web-server)
            web-server
            ;;
        tests)
            tests
            ;;
        *)
            echo "Unrecognized command '$1'"
            exit 1
            ;;
    esac
}

main "$@"
