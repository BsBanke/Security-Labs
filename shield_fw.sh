#!/bin/bash

# ==========================================
# "THE SHIELD" - FIREWALL HARDENING UTILITY
# ==========================================

echo "========================================="
echo " Applying Advanced Firewall Hardening... "
echo "========================================="

# 1. Reset UFW to completely factory default (clears old rules)
echo "[*] Resetting UFW to default state..."
sudo ufw --force reset

# 2. Set the global incoming/outgoing  policies..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 3. Open the specific allowed ports
echo "[*] Allowing secure incoming ports (22 & 443)..."
sudo ufw allow 22/tcp comment 'Secure SSH Management'
sudo ufw allow 443/tcp comment 'Secure Web Traffic HTTPS'

$ 4. Enable the firewall
echo "[*] Activating the firewall firewall engine..."
sudo ufw enable

echo "=================================="
echo " FIREWALL ENFORCEMENT COMPLETE! "
echo "=================================="
echo sudo ufw status verbose
echo "=================================="
