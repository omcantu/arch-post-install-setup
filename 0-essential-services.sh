# Enable Network Manager (essential for all network connectivity)
sudo systemctl enable --now NetworkManager

# Install and enable the Common Unix Printing System (CUPS)
sudo pacman -S cups
sudo systemctl enable --now cups.service
