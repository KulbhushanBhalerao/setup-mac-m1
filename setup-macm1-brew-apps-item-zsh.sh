#!/bin/bash

# Ensure system is up-to-date
sudo softwareupdate --install --all

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update and upgrade Homebrew
brew update && brew upgrade

# Install CLI tools
brew install ansible ansible-lint ant argocd augeas autoconf azure-cli bash \
    bash-completion bash-completion@2 black brotli c-ares ca-certificates cairo \
    certbot certifi cffi cryptography curl dialog fontconfig freetype fzf gdbm \
    gettext gh giflib git git-lfs gmp gnu-getopt gnupg gnutls go gradle graphite2 \
    harfbuzz helm icu4c@76 icu4c@77 influxdb-cli jq jpeg-turbo k3d k9s kubectx \
    kubelogin kubent kubernetes-cli kustomize libassuan libevent libgcrypt \
    libgpg-error libidn2 libksba libnghttp2 libpng libssh libssh2 libtasn1 \
    libtiff libtommath libunistring libusb libuv libx11 libxau libxcb libxdmcp \
    libxext libxrender libyaml little-cms2 lua lz4 lzo m4 maven minikube mpdecimal \
    ncurses nettle node npth oniguruma openjdk openjdk@17 openssl@3 p11-kit pass \
    pcre2 pinentry pixman pkgconf podman pycparser pyenv python-packaging \
    python-tk@3.9 python@3.12 python@3.13 python@3.9 qrencode rtmpdump ruby \
    sqlite starship strongswan tcl-tk tcl-tk@8 telnet tree unbound vim wget \
    xorgproto xz yamllint yq zsh-syntax-highlighting zstd

# Install GUI applications
brew install --cask visual-studio-code postman github desktop zoom archi dbeaver \
    docker google-drive drawio openlens

# Install iTerm2 and configure zsh
brew install --cask iterm2

# Set zsh as default shell
chsh -s $(which zsh)

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Starship prompt
if ! command -v starship &> /dev/null; then
    echo "Installing Starship..."
    brew install starship
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

# Apply changes
source ~/.zshrc

echo "✅ Setup complete! Restart your terminal to apply all changes."
