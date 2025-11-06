echo "-> Starting Security Configuration (Firewall and AppArmor)..."

# Install Uncomplicated Firewall (UFW)
sudo pacman -S --noconfirm ufw

# Set sensible defaults and enable UFW
sudo ufw default deny incoming
sudo ufw enable
echo "UFW Firewall enabled and set to deny incoming."

# Install AppArmor
sudo pacman -S --noconfirm apparmor

# Define the parameters we want to add
APPARMOR_PARAMS=" apparmor=1 security=apparmor"
GRUB_CONFIG_FILE="/etc/default/grub"

echo "-> Adding AppArmor kernel parameters to GRUB..."

# 1. Use sed to safely append the parameters inside the final quote
sudo sed -i "s/\(GRUB_CMDLINE_LINUX_DEFAULT=\"[^\"]*\)\"/\1${APPARMOR_PARAMS}\"/" "$GRUB_CONFIG_FILE"

# 2. Use grep to print the specific modified line for verification
echo "Modified line in $GRUB_CONFIG_FILE:"
grep "^GRUB_CMDLINE_LINUX_DEFAULT=" "$GRUB_CONFIG_FILE"

# Update GRUB configuration
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Enable the AppArmor service
sudo systemctl enable --now apparmor.service
echo "AppArmor service enabled."

echo "Done with firewall and apparmor install"
