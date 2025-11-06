# Install and Configure CPU Microcode (Security)
# For Intel CPUs:
sudo pacman -S intel-ucode

# update GRUB to load the microcode
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "Done with microcode install"
