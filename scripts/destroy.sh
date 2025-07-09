#!/bin/bash

set -e

rm -rf calisma_alani/
find .distrobox -mindepth 1 ! -path ".distrobox/.distroboxrc" \
    ! -path ".distrobox/.motd" \
    ! -path ".distrobox/.profile" \
    ! -path ".distrobox/.bashrc" \
    ! -path ".distrobox/.bash_aliases" \
    ! -path ".distrobox/.bash_completion.d" \
    ! -path ".distrobox/.bash_completion.d/*" \
    ! -path ".distrobox/.bash_completion" \
    ! -path ".distrobox/.local" \
    ! -path ".distrobox/.local/share" \
    ! -path ".distrobox/.local/share/konsole" \
    ! -path ".distrobox/.local/share/konsole/*" \
    ! -path ".distrobox/.config" \
    ! -path ".distrobox/.config/konsolerc" \
    -exec rm -rf {} +