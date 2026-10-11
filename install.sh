#!/bin/bash
# Dotfiles Deployment Script for Arch/CachyOS
# Usage: ./dotfiles-install.sh

set -e

echo "🚀 Dotfiles Deployment Starting..."

# 1. Install Pacman packages
echo "📦 Installing base packages..."
sudo pacman -S --needed --noconfirm \
    fish neovim hyprland \
    alacritty kitty \
    fastfetch lsd bat zoxide thefuck yazi \
    ryzenadj \
    ripgrep fd git nodejs npm python3 gcc \
    hyprlock hypridle \
    thunar \
    ttf-firacode-nerd noto-fonts noto-fonts-emoji

# 2. Install AUR packages (yay)
echo "📦 Installing AUR packages..."
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

yay -S --needed --noconfirm \
    omniroute \
    hyprpm \
    quickshell \
    illogical-impulse

# 3. Install LinuxBrew
echo "🍺 Setting up LinuxBrew..."
if [ ! -d "/home/linuxbrew/.linuxbrew" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 4. Copy config files
echo "📁 Deploying configs..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup existing configs
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

for dir in hypr nvim fish fastfetch kitty alacritty quickshell illogical-impulse wlogout fuzzel; do
    if [ -d "$HOME/.config/$dir" ]; then
        echo "  Backing up $dir..."
        mv "$HOME/.config/$dir" "$BACKUP_DIR/"
    fi
done

# Link new configs
mkdir -p ~/.config
cp -r "$SCRIPT_DIR/.config/hypr" ~/.config/
cp -r "$SCRIPT_DIR/.config/nvim" ~/.config/
cp -r "$SCRIPT_DIR/.config/fish" ~/.config/
cp -r "$SCRIPT_DIR/.config/fastfetch" ~/.config/
cp -r "$SCRIPT_DIR/.config/kitty" ~/.config/
cp -r "$SCRIPT_DIR/.config/alacritty" ~/.config/
[ -d "$SCRIPT_DIR/.config/quickshell" ] && cp -r "$SCRIPT_DIR/.config/quickshell" ~/.config/
[ -d "$SCRIPT_DIR/.config/illogical-impulse" ] && cp -r "$SCRIPT_DIR/.config/illogical-impulse" ~/.config/
[ -d "$SCRIPT_DIR/.config/wlogout" ] && cp -r "$SCRIPT_DIR/.config/wlogout" ~/.config/
[ -d "$SCRIPT_DIR/.config/fuzzel" ] && cp -r "$SCRIPT_DIR/.config/fuzzel" ~/.config/

# 5. Copy scripts
echo "📜 Installing scripts..."
mkdir -p ~/.local/bin
cp "$SCRIPT_DIR/scripts/ryzen-sessiz.sh" ~/.local/bin/ 2>/dev/null || echo "Ryzen scripts not found, skipping..."
cp "$SCRIPT_DIR/scripts/ryzen-performans.sh" ~/.local/bin/ 2>/dev/null || echo "Ryzen scripts not found, skipping..."
chmod +x ~/.local/bin/ryzen-*.sh 2>/dev/null || true

# 6. Claude-omniroute settings
echo "⚙️ Copying claude-omniroute settings..."
mkdir -p ~/.claude-omniroute
[ -f "$SCRIPT_DIR/.claude-omniroute/settings.json" ] && cp "$SCRIPT_DIR/.claude-omniroute/settings.json" ~/.claude-omniroute/

# 7. Install Claude Code
if ! command -v claude &> /dev/null; then
    echo "📥 Installing Claude Code..."
    curl -fsSL https://anthropic.com/claude-code/install.sh | bash
fi

# 8. Environment setup reminder
echo ""
echo "✅ Deployment complete!"
echo ""
echo "⚠️ MANUAL STEPS REQUIRED:"
echo "1. Create ~/.env with your secrets:"
echo "   ANTHROPIC_AUTH_TOKEN=\"your-token\""
echo "   NGROK_AUTHTOKEN=\"your-ngrok-token\""
echo ""
echo "2. For ryzen scripts (if using AMD), add to sudoers:"
echo "   sudo visudo -f /etc/sudoers.d/ryzenadj"
echo "   Add line: $USER ALL=(ALL) NOPASSWD: $HOME/ryzen-sessiz.sh, $HOME/ryzen-performans.sh"
echo ""
echo "3. Install Neovim plugins (first launch will auto-install)"
echo ""
echo "4. Set fish as default shell:"
echo "   chsh -s /usr/bin/fish"
echo ""
echo "5. Install pnpm if needed:"
echo "   curl -fsSL https://get.pnpm.io/install.sh | sh -"
echo ""
echo "6. Reboot or run: hyprctl reload"
echo ""
echo "Backup of old configs: $BACKUP_DIR"