#!/usr/bin/env bash

source utils.sh
source lang/ruby.sh
source lang/python.sh

MAC_VERSION=$(sw_vers -productVersion | cut -d . -f 1)
SDK_VERSION=$(xcrun --show-sdk-version | cut -d . -f 1)

function brew_init() {
    if ! command -v brew &> /dev/null; then
        pinfo "==> Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || return 1
    else
        pinfo "==> Homebrew already installed, skipping..."
    fi

    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
    pinfo "==> Updating Homebrew package state..."
    brew bundle || return 1
}

function ln_dotfiles() {
	pinfo "==> Linking dotfiles..."
    for fd in dotfiles/*; do
        src_fd="$(pwd)/$fd"
        tgt_fd="$HOME/.$(echo $fd | cut -d / -f 2)"
        if [ -f "$fd" ]; then
            ln -sf $src_fd $tgt_fd || return 1
        elif [ -d "$fd" ]; then
            ln -sF $src_fd $tgt_fd || return 1
        fi
    done

    source $HOME/.zshrc || return 1
}

function jmacbox_init() {
    brew_init || exit 1
    ln_dotfiles || exit 1
    ruby_init || exit 1
    python_init || exit 1

    pinfo "Setup complete!"
}

jmacbox_init
