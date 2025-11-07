# Install the KDE Application Meta-Package (Dolphin, Konsole, Okular, etc.)
sudo pacman -S kde-applications-meta

# Install Essential Software (Browser, Office, Multimedia)
sudo pacman -S firefox libreoffice-fresh pipewire-media-session ffmpeg

# Install Recommended Fonts for better rendering and compatibility
sudo pacman -S ttf-dejavu noto-fonts

# Install the KDE Update Notifier Plasmoid (AUR)
paru -S plasma6-applets-arch-update-notifier

paru -S localsend-bin
paru -S plasma6-applets-kurve
paru -S visual-studio-code-bin
paru -S zoom

echo "Done with KDE Essentials"
