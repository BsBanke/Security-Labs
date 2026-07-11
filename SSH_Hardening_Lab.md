Lab 2: Cryptographic Authentication & Network Hardening

Objective: To eliminate brute-force attacks and unathorized lateral movements by transitioning an active SSH deployment from password authentication to cryptographic key pairs, followed by a strict ingress network firewall restriction

Topology & Tools:
Attack Surface/Target: Linux Mint laptop (Host)
Authorized Administrator Endpoint: Windows 11 PC (Client)
Protocols: SSH  ( Port 22/TCP), OpenSSH Engine
Firewall Configuration: Uncomplicated Firewall (UFW)

Phase 1: Deploying Cryptographic Identity
1. Generated an asymmetric **ED25519** key pair on the Windows admin endpoint:
```cmd
ssh-keygen -t ed25519

2. Manually appended the public key (id_ed25519.pub) directly into the targets authorized ecosystem. (~/.ssh/authorized_keys) and restricted folder structures to prevent unauthorized read permissions (chmod 700 and chmod 600)

3. Confirmed successful passwordless cryptographic authentication across the local subnet.

Phase 2: OpenSSH Daemon Hardening

1. Modified /etc/ssh/sshd_config policies:
	PasswordAuthentication no
	PubkeyAuthentication yes
2. Cycled the background daemon to instantly enforce the strict identity rules:
	sudo systemctl restart ssh

Phase 3: Network isolation & shadow rule remediation 
Even with key pairs enforced, allowing global network probing introduces unnecessary exposure. The host network layer was hardened to restrict access exclusivly to the management endpoint

1. Established a strict default deny incoming firewall posture
2. Discovered and purged legacy default shadow rules ( ALLOW in Anywhere) that were bypassing intended restrictions
3. Applied a pintpoint whitelist rule targeting the administrators explicit local IP Address:
	sudo ufw allow from 192.168.x.x to any port 22 proto tcp

Verification: 
Running sudp ufw status verbose confirms that the incoming perimeter is securely locked down. Port 22 is entirely invisible to the rest of the network, dropping unauthorized packets silently while maintaining a direct, secure line to the authorized workstation

