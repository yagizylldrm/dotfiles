#!/bin/bash
# Performans mod: Tam güç, maksimum performans
if sudo ryzenadj --stapm-limit=35000 --fast-limit=45000 --slow-limit=35000 --tctl-temp=90; then
    echo "[✓] Performans mod aktif: 35W TDP, 90°C max"
    echo "  → Stapm: 35W | Fast: 45W | Slow: 35W"
else
    echo "[✗] Performans mod ayarlanamadı"
    exit 1
fi