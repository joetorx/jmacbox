RUBY_DIR="$HOME/.rubies"
RUBY_VERSIONS=(
    3.3.4
    3.4.10
)

function ruby_init() {
    if (( $SDK_VERSION >= 27 && $MAC_VERSION < 27 )); then
        # https://github.com/postmodern/ruby-install/issues/528
        # https://bugs.ruby-lang.org/issues/22311
        export ac_cv_func_dup3=no ac_cv_func_pipe2=no
    fi

    for ruby_ver in "${RUBY_VERSIONS[@]}"; do
        if [ ! -d "$RUBY_DIR/ruby-$ruby_ver" ]; then
            pinfo "==> Installing Ruby $ruby_ver"
            ruby-install ruby $ruby_ver || return 1
        else
            pinfo "==> Ruby $ruby_ver already installed, skipping..."
        fi
    done
}
