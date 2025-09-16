#!/bin/bash

# Source common functions - this will give us access to $ROOT_DIR
source "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/functions/common"

# Check if we're on macOS
if [ "$(uname)" != "Darwin" ]; then
    print_line "This script is only for macOS"
    exit 1
fi

print_line "Setting default settings."

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Ask for the administrator password upfront
sudo -v

# Function to check if a defaults command succeeded
set_default() {
    if ! "$@"; then
        print_line "Failed to set: $@"
    fi
}

# Boot
print_line " - Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

print_line " - Disable sound effects within UI. Eg, trash empty, screenshot, etc"
set_default defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0

print_line " - Disable transparency in the menu bar and elsewhere"
set_default defaults write com.apple.universalaccess reduceTransparency -bool true

print_line " - Set sidebar icon size to medium"
set_default defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

print_line " - Always show scrollbars"
set_default defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

print_line " - Increase window resize speed for Cocoa applications"
set_default defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

print_line " - Enable full keyboard access for all controls"
set_default defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

print_line " - Set language and text formats"
set_default defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
set_default defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
set_default defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
set_default defaults write NSGlobalDomain AppleMetricUnits -bool false

print_line " - Stop iTunes from responding to the keyboard media keys"
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null || true

print_line " - Save screenshots in PNG format"
set_default defaults write com.apple.screencapture type -string "png"

print_line " - Disable shadow in screenshots"
set_default defaults write com.apple.screencapture disable-shadow -bool true

print_line " - Enable HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

print_line " - Green highlight color"
set_default defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

print_line " - Show all extensions"
set_default defaults write NSGlobalDomain AppleShowAllExtensions -bool true

print_line " - Set key repeat rate"
set_default defaults write NSGlobalDomain InitialKeyRepeat -int 15
set_default defaults write NSGlobalDomain KeyRepeat -int 2

# Disable auto-correct features
print_line " - Disable auto-correct"
set_default defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
set_default defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
set_default defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
set_default defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Trackpad settings
print_line " - Configure trackpad settings"
set_default defaults write com.apple.AppleMultitouchMouse MouseHorizontalScroll -int 1
set_default defaults write com.apple.AppleMultitouchMouse MouseVerticalScroll -int 1
set_default defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
set_default defaults write -g com.apple.swipescrolldirection -bool true
set_default defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

# Dock settings
print_line " - Configure dock settings"
set_default defaults write com.apple.dock orientation -string 'left'
set_default defaults write com.apple.dock expose-group-apps -bool true
set_default defaults write com.apple.dock expose-group-by-app -bool true
set_default defaults write com.apple.dock magnification -bool false
set_default defaults write com.apple.dock tilesize -int 34
set_default defaults write com.apple.dock show-recents -bool false

# Hot corners
print_line " - Configure hot corners"
set_default defaults write com.apple.dock wvous-tl-corner -int 0
set_default defaults write com.apple.dock wvous-tl-modifier -int 0
set_default defaults write com.apple.dock wvous-tr-corner -int 0
set_default defaults write com.apple.dock wvous-tr-modifier -int 0
set_default defaults write com.apple.dock wvous-bl-corner -int 0
set_default defaults write com.apple.dock wvous-bl-modifier -int 0
set_default defaults write com.apple.dock wvous-br-corner -int 0
set_default defaults write com.apple.dock wvous-br-modifier -int 0

# Save panel settings
print_line " - Configure save panel settings"
set_default defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
set_default defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
set_default defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Security and privacy
print_line " - Configure security settings"
set_default defaults write com.apple.screensaver askForPassword -bool true
set_default defaults write com.apple.screensaver askForPasswordDelay -int 0

print_line " - Disable Siri"
set_default defaults write com.apple.assistant.support "Assistant Enabled" -bool false

print_line " - Enable volume feedback"
set_default defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool true

print_line " - Enable Safari development menu"
set_default defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Finder settings
print_line " - Configure Finder settings"
set_default defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
set_default defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
set_default defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
set_default defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
set_default defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
set_default defaults write com.apple.finder ShowRecentTags -bool false
set_default defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true
set_default defaults write com.apple.finder SidebarMediaBrowserSectionDisclosedState -bool true
set_default defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true
set_default defaults write com.apple.finder SidebarSharedSectionDisclosedState -bool true
set_default defaults write com.apple.finder NewWindowTarget -string "PfDe"
set_default defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"
set_default defaults write com.apple.finder ShowStatusBar -bool true
set_default defaults write com.apple.finder ShowPathbar -bool true
set_default defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
set_default defaults write com.apple.finder _FXSortFoldersFirst -bool true
set_default defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
set_default defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
set_default defaults write com.apple.finder WarnOnEmptyTrash -bool false

# DS_Store settings
print_line " - Configure .DS_Store settings"
set_default defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
set_default defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

print_line " - Show battery percentage"
set_default defaults write com.apple.menuextra.battery ShowPercent -string "YES"

print_line " - Disable disk image verification"
set_default defaults write com.apple.frameworks.diskimages skip-verify -bool true
set_default defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
set_default defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

print_line " - Configure menu bar icon spacing"
set_default defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6
set_default defaults -currentHost write -globalDomain NSStatusItemSpacing -int 6

print_line "All defaults have been set. Note that some of these changes require a logout/restart to take effect."

# Kill affected applications
for app in "Dock" "Finder" "Safari" "SystemUIServer"; do
    killall "${app}" >/dev/null 2>&1
done
