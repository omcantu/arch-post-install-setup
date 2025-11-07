#!/bin/bash

# --- Function to check for and install Flatpak (optional, but good practice) ---
check_flatpak() {
  if ! command -v flatpak &>/dev/null; then
    echo "🚨 Flatpak is not installed. Please install Flatpak first."
    # Note: Installation methods vary by distribution (e.g., apt, dnf, pacman).
    # We won't attempt to install it here, as it requires elevated privileges and
    # is distribution-specific, but we'll inform the user.
    exit 1
  fi
  echo "✅ Flatpak is installed."
}

# --- Function to ensure Flathub remote is added ---
add_flathub_remote() {
  if ! flatpak remotes | grep -q "flathub"; then
    echo "🌐 Adding Flathub remote..."
    # Add the Flathub remote if it's not already present
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo "✅ Flathub remote added."
  else
    echo "✅ Flathub remote is already present."
  fi
}

# --- Function to install a Flatpak app ---
# $1: Application ID (e.g., com.discordapp.Discord)
# $2: Installation location (system or user)
install_flatpak_app() {
  APP_ID="$1"
  INSTALL_LOCATION="$2"
  INSTALL_FLAG=""

  if [ "$INSTALL_LOCATION" == "user" ]; then
    INSTALL_FLAG="--user"
  fi

  echo ""
  echo "⚙️  Attempting to install **$APP_ID** ($INSTALL_LOCATION)..."

  # Use 'flatpak install -y' for non-interactive installation
  # The 'flathub' remote is explicitly included for clarity, though often optional
  if flatpak install -y $INSTALL_FLAG flathub "$APP_ID"; then
    echo "👍 **$APP_ID** installed successfully to **$INSTALL_LOCATION**."
  else
    echo "❌ ERROR: Failed to install **$APP_ID**. Please check the Flatpak error message above."
    # Continue to the next app even if one fails
  fi
}

# ----------------- Main Execution -----------------

check_flatpak
add_flathub_remote

echo ""
echo "--- Starting Flatpak Application Installation ---"
echo ""

# The list of applications to install:
# Format: install_flatpak_app "Application_ID" "installation_location"

# User Installations
install_flatpak_app "com.discordapp.Discord" "user"
install_flatpak_app "com.github.PintaProject.Pinta" "user"
install_flatpak_app "com.spotify.Client" "user"
install_flatpak_app "io.typora.Typora" "user"
install_flatpak_app "md.obsidian.Obsidian" "user"

# System Installations (will require privilege elevation, likely a password prompt)
install_flatpak_app "com.github.naaando.lyrics" "system"
install_flatpak_app "io.github.kolunmi.Bazaar" "system"
install_flatpak_app "io.github.mezoahmedii.Picker" "system"
install_flatpak_app "net.davidotek.pupgui2" "system"

echo ""
echo "--- Flatpak Installation Script Finished ---"
echo ""
