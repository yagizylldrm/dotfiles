#!/bin/bash
# Sessiz mod: Düşük güç tüketimi, daha az ısı
if sudo ryzenadj --stapm-limit=15000 --fast-limit=18000 --slow-limit=15000 --tctl-temp=75; then
    echo "[✓] Sessiz mod aktif: 15W TDP, 75°C max"
    echo "  → Stapm: 15W | Fast: 18W | Slow: 15W"
else
    echo "[✗] Sessiz mod ayarlanamadı"
    exit 1
fi
