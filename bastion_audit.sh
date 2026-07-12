#!/bin/bash

# =========================================================
# "THE BASTION+ - AUTOMATED SECURITY AUDIT
# =========================================================


echo "========================================="
echo " Starting System Security Audit... "
echo "========================================="


# 1. Check SSH Password Authentication Status
echo -n "[*] Checking SSH Password Policy... "
if grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config; then
	echo "SECURE (Passwords Disabled)"
else 
	echo "WARNING (Password Authentication is ENABLED!)"
fi

# 2. Check UFW Firewall Status
echo -n "[*] Checking Firewall Satus... "
if sudo ufw status | grep -q "Status: active"; then
	echo "SECURE (Firewall is Active)"
else
	echo "WARNING (Firewall is DISABLED!)"
fi

# 3. List Open Network Ports
echo ""
echo "=========================================="
echo " Active Listening Ports (Network Footprint)"
echo "=========================================="
ss -tulpn | grep LISTEN | awk '{print $5, $6}'
echo "=========================================="
