# Dotfiles

Arch Linux / CachyOS dotfiles for Hyprland, Neovim, Fish, and terminal setup.

## Quick Install

```bash
git clone https://github.com/yagizylldrm/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Included Configs

- **Hyprland**: Modular WM setup with quickshell
- **Neovim**: Full IDE setup with Lazy.nvim, LSP, formatters
- **Fish**: Interactive shell with HomeBrew, fastfetch, aliases
- **Terminals**: Kitty and Alacritty configs
- **Tools**: Fastfetch, btop, cava, wlogout, fuzzel
- **Ryzen**: Silent and Performance thermal profiles (AMD only)

## Post-Install Steps

1. Create `~/.env`:
```bash
ANTHROPIC_AUTH_TOKEN="your-token"
NGROK_AUTHTOKEN="your-token"
```

2. For AMD thermal scripts (optional):
```bash
sudo visudo -f /etc/sudoers.d/ryzenadj
# Add: $USER ALL=(ALL) NOPASSWD: $HOME/ryzen-sessiz.sh, $HOME/ryzen-performans.sh
```

3. Set Fish as default shell:
```bash
chsh -s /usr/bin/fish
```
