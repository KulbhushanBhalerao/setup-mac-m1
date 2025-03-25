#!/bin/bash

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages and casks from Brewfile
echo "Installing Homebrew packages and casks..."
brew bundle --file=~/migrate-apps/Brewfile

# Restore Terminal app preferences
echo "Restoring Terminal app preferences..."
cp ~/migrate-apps/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist
defaults read com.apple.Terminal &>/dev/null || echo "Failed to load Terminal preferences. Please check manually."

# Restore iTerm2 preferences
echo "Restoring iTerm2 preferences..."
cp ~/migrate-apps/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
defaults read com.googlecode.iterm2 &>/dev/null || echo "Failed to load iTerm2 preferences. Please check manually."

# Restore bash profile
echo "Restoring bash profile..."
cp ~/migrate-apps/bash_profile ~/.bash_profile
source ~/.bash_profile

# Install additional applications (check availability)
echo "Installing additional applications..."
brew install --cask docker || echo "Docker not available via Homebrew. Install manually."
brew install --cask google-chrome || echo "Google Chrome not available via Homebrew. Install manually."
brew install --cask nordvpn || echo "NordVPN not available via Homebrew. Install manually."
brew install --cask openlens || echo "OpenLens not available via Homebrew. Install manually."
brew install --cask postman || echo "Postman not available via Homebrew. Install manually."
brew install --cask privatevpn || echo "PrivateVPN not available via Homebrew. Install manually."
brew install --cask slack || echo "Slack not available via Homebrew. Install manually."
brew install --cask sourcetree || echo "SourceTree not available via Homebrew. Install manually."
brew install --cask tunnelblick || echo "Tunnelblick not available via Homebrew. Install manually."
brew install --cask whatsapp || echo "WhatsApp not available via Homebrew. Install manually."
brew install --cask microsoft-remote-desktop || echo "Microsoft Remote Desktop not available via Homebrew. Install manually."
brew install --cask zoom || echo "Zoom not available via Homebrew. Install manually."
brew install --cask mindnode || echo "MindNode not available via Homebrew. Consider installing via the Mac App Store."
brew install --cask iterm2 || echo "iTerm2 not available via Homebrew. Install manually."

# Install fonts for Zsh
echo "Installing fonts for Zsh..."
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
echo "Fonts installed."

# Install Starship prompt
echo "Installing Starship prompt..."
brew install starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo "Starship prompt installed."

# Set up Zsh and Oh My Zsh
echo "Setting up Zsh and Oh My Zsh..."
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Zsh custom plugins and themes
echo "Installing Zsh custom plugins and themes..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Restore .zshrc
echo "Restoring .zshrc..."
cp ~/migrate-apps/zshrc ~/.zshrc

echo "Setup complete!"
