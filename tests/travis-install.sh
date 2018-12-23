#!/usr/bin/env bash

set -euo pipefail

source "tests/logging.sh"

info "TRAVIS_OS_NAME=$TRAVIS_OS_NAME"
case "$TRAVIS_OS_NAME" in
  osx)
    info "Installing macOS dependencies with Homebrew..."
    brew bundle
    ;;

  linux)
    travis_fold_start mlton "Installing MLton..."

    sudo mkdir -p /usr/local/mlton
    cd /usr/local/mlton

    info "Getting MLton binary tarball..."
    sudo wget "https://github.com/MLton/mlton/releases/download/on-20180207-release/mlton-20180207-1.amd64-linux.tgz"
    sudo tar -xzf "mlton-20180207-1.amd64-linux.tgz"

    info "Copying binary tarball over /usr/local..."
    sudo cp -r mlton-20180207-1.amd64-linux/* /usr/local

    info "Overwriting system ld with ld 2.26"
    # Ubuntu 14.04 ships with GNU ld 2.24, but I think that the MLton binary
    # distro was built with 2.26...? We can remove this when the default ld is
    # a high enough version
    sudo apt-get install binutils-2.26
    /usr/bin/ld -v
    sudo cp /usr/bin/ld-2.26 /usr/bin/ld

    info "MLton version:"
    mlton

    success "Installed MLton."

    travis_fold_end mlton
    travis_fold_start dpkg "dpkg setup..."

    # SML/NJ is not 64-bit yet, as of 110.85.
    # This section enables 'gcc -m32' on Ubuntu (which SML/NJ uses internally.)
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install libc6:i386 gcc-multilib g++-multilib

    travis_fold_end dpkg
    travis_fold_start smlnj "Installing SML/NJ..."

    sudo mkdir -p /usr/local/sml
    cd /usr/local/sml

    info "Getting SML/NJ binary tarball..."
    sudo wget "http://smlnj.cs.uchicago.edu/dist/working/110.85/config.tgz"
    sudo tar -xzvf "config.tgz"

    info "Running config/install.sh..."
    sudo config/install.sh

    info "Linking into /usr/local/bin..."
    sudo ln -s /usr/local/sml/bin/* /usr/local/bin

    travis_fold_end smlnj

    ;;
  *)
    error "Unrecognozed TRAVIS_OS_NAME: $TRAVIS_OS_NAME"
    ;;
esac
