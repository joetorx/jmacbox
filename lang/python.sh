PYTHON_DIR="$HOME/.pyenv/versions"
PYTHON_VERSIONS=(
    3.13.16
)

function python_init() {
    for python_ver in "${PYTHON_VERSIONS[@]}"; do
        if [ ! -d "$PYTHON_DIR/$python_ver" ]; then
            pinfo "==> Installing Python $python_ver"
            pyenv install $python_ver || return 1
        else
            pinfo "==> Python $python_ver already installed, skipping..."
        fi
    done

    pyenv global "${PYTHON_VERSIONS[0]}"
}
