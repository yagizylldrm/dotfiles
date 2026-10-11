# Load environment variables from ~/.env if present
if test -f "$HOME/.env"
    for line in (cat "$HOME/.env")
        if test -n "$line"; and not string match -qr "^#" -- "$line"
            set -l key (string split -m 1 = -- "$line")[1]
            set -l val (string split -m 1 = -- "$line")[2]
            set -l val_clean (string trim -c "\"'" -- "$val")
            set -gx $key "$val_clean"
        end
    end
end

if status is-interactive
    # 1. LinuxBrew Setup
    # This must run first so 'lsd', 'bat', and 'fzf' are found in your PATH
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

    # 2. Aliases
    # Note: No '=' sign in Fish aliases
    alias ls "lsd"
    alias cat "bat"

    # 3. Tool Initializations
    # zoxide (Replaces 'cd')
    zoxide init fish | source
    # thefuck (Auto-correction)
    thefuck --alias | source

    # 4. Yazi Function (Ported from your Zsh function)
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # 5. Startup Splash
    # Clears screen and runs fastfetch every time you open a terminal
    clear
    fastfetch

    alias pip "python -m pip"
end

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Ryzen Limit Kontrol Aliasları
alias sessiz-mod="sudo $HOME/ryzen-sessiz.sh"
alias performans-mod="sudo $HOME/ryzen-performans.sh"

function claude-local
    # 1. 20128 portu dinleniyor mu kontrol et
    if not nc -z 127.0.0.1 20128
        echo "Omniroute arka planda başlatılıyor..."
        nohup omniroute --no-open >/dev/null 2>&1 &

        set -l retries 10
        while not nc -z 127.0.0.1 20128; and test $retries -gt 0
            sleep 0.5
            set retries (math $retries - 1)
        end
    end

    # 2. Çevre Değişkenleri
    set -lx ANTHROPIC_BASE_URL "http://localhost:20128"
    set -lx ANTHROPIC_MODEL "claude-omniroute"
    set -lx ANTHROPIC_API_KEY ""
    # ANTHROPIC_AUTH_TOKEN ~/.env dosyasından yüklenir
    set -lx CLAUDE_CONFIG_DIR "$HOME/.claude-omniroute"

    # Alt Ajan (Sub-agent) yönlendirmeleri
    set -lx CLAUDE_CODE_SUBAGENT_MODEL "claude-omniroute"
    set -lx ANTHROPIC_DEFAULT_SONNET_MODEL "claude-omniroute"
    set -lx ANTHROPIC_DEFAULT_OPUS_MODEL "claude-omniroute"
    set -lx ANTHROPIC_DEFAULT_HAIKU_MODEL "claude-omniroute"

    # 3. Claude çalıştır ve çıkışta durdur
    claude $argv

    echo -e "\nOmniroute kapatılıyor..."
    omniroute stop
end
fish_add_path "$HOME/.local/bin"
set -gx XDG_DATA_DIRS /usr/local/share /usr/share
