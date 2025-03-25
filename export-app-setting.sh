#!/bin/bash

# Create migrate-apps directory
SCRIPT_DIR=$(dirname "$0")
MIGRATE_DIR="$SCRIPT_DIR/migrate-apps"
mkdir -p "$MIGRATE_DIR"

# Export Homebrew packages and casks
echo "Exporting Homebrew packages and casks..."
brew bundle dump --file="$MIGRATE_DIR/Brewfile" --force
echo "Brewfile generated at $MIGRATE_DIR/Brewfile."

# Backup Terminal app preferences
echo "Backing up Terminal app preferences..."
TERMINAL_PREFS_DIR="$HOME/Library/Preferences"
cp "$TERMINAL_PREFS_DIR/com.apple.Terminal.plist" "$MIGRATE_DIR/com.apple.Terminal.plist"
echo "Terminal preferences backed up."

# Backup iTerm2 preferences
echo "Backing up iTerm2 preferences..."
ITERM2_PREFS_DIR="$HOME/Library/Preferences"
cp "$ITERM2_PREFS_DIR/com.googlecode.iterm2.plist" "$MIGRATE_DIR/com.googlecode.iterm2.plist"
echo "iTerm2 preferences backed up."

# Backup bash profile
echo "Backing up bash profile..."
cp ~/.bash_profile "$MIGRATE_DIR/bash_profile"
echo "Bash profile backed up."

# Generate Homebrew installation script for the new MacBook
cat <<EOF > "$MIGRATE_DIR/setup-new-mac.sh"
#!/bin/bash

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Source Homebrew environment variables
echo "Sourcing Homebrew environment variables..."
eval "\$(/opt/homebrew/bin/brew shellenv)"

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
echo 'eval "\$(starship init zsh)"' >> ~/.zshrc
echo "Starship prompt installed."

# Set up Zsh and Oh My Zsh
echo "Setting up Zsh and Oh My Zsh..."
brew install zsh
sh -c "\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Zsh custom plugins and themes
echo "Installing Zsh custom plugins and themes..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Restore .zshrc
echo "Restoring .zshrc..."
cp ~/migrate-apps/zshrc ~/.zshrc

# Configure iTerm2 to use Zsh
echo "Configuring iTerm2 to use Zsh..."
defaults write com.googlecode.iterm2 "Default Bookmark Command" -string "/bin/zsh"

echo "Setup complete!"
EOF

chmod +x "$MIGRATE_DIR/setup-new-mac.sh"
echo "Script to set up the new MacBook generated at $MIGRATE_DIR/setup-new-mac.sh."

# Backup Zsh customizations
echo "Backing up Zsh customizations..."
cp ~/.zshrc "$MIGRATE_DIR/zshrc"
echo "Zsh customizations backed up."

echo "All configurations and commands have been exported. Transfer the folder $MIGRATE_DIR to your new MacBook and run $MIGRATE_DIR/setup-new-mac.sh to set it up."
