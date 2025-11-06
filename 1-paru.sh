# # 1. Install necessary dependencies for building AUR packages
sudo pacman -S --needed base-devel git

# 2. Clone the paru repository
git clone https://aur.archlinux.org/paru.git

# 3. Build and install paru
cd paru
makepkg -si
cd ..
rm -rf paru
echo "Done installing paru!"
