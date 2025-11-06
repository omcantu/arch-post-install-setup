# 1. Install Snapper, GRUB integration, pacman hook, and the GUI tool
paru -S snapper grub-btrfs snap-pac grub-btrfs-overlayfs btrfs-assistant

# 2. Create the Snapper configuration for the root filesystem (assumes Btrfs root subvolume @ is mounted at /)
sudo snapper -c root create-config /

# 3. Set permissions for the snapshots directory
sudo chmod a+rx /.snapshots

# 4. Enable the grub-btrfs daemon to auto-update GRUB when snapshots are taken
sudo systemctl enable --now grub-btrfsd.service

# 5. Add the grub-btrfs-overlayfs hook to your initramfs configuration
# Add 'grub-btrfs-overlayfs' to the end of the HOOKS array:
# HOOKS=(base udev autodetect ... filesystems fsck grub-btrfs-overlayfs)
# Add grub-btrfs-overlayfs to the end of the HOOKS array
sudo sed -i '/^HOOKS=/s/)$/ grub-btrfs-overlayfs)/' /etc/mkinitcpio.conf

# 6. Rebuild initramfs and update GRUB (Finalize rollback setup)
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "Done with snapper install"
