#!/bin/sh
source ./functions/common

print_line "Setting default settings."

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

print_line " - Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

print_line " - Disable transparency in the menu bar and elsewhere on Yosemite"
defaults write com.apple.universalaccess reduceTransparency -bool true

print_line " - Set sidebar icon size to medium"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

print_line " - Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

print_line " - Increase window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

print_line " - Enable full keyboard access for all controls"
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

print_line " - Set language and text formats"
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

print_line " - Stop iTunes from responding to the keyboard media keys"
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

print_line " - Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

print_line " - Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

print_line " - Enable HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true


###
#print_line " - NSGlobalDomain settings import for currentHost"
#defaults -currentHost import NSGlobalDomain plists/NSGlobalDomain_ByHost.plist

print_line " - Green highlight color"
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

#print_line " - Pink accent color"
#defaults write NSGlobalDomain AppleAccentColor -integer 6

print_line " - Show all extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

print_line " - Set key repeat rate"
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

print_line " - Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

print_line " - Disable auto-capitalization"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

print_line " - Disable quote substitution"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

print_line " - Disable dash substitution"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

print_line " - Enable sane trackpad scrolling"
defaults write com.apple.AppleMultitouchMouse MouseHorizontalScroll -int 1
defaults write com.apple.AppleMultitouchMouse MouseVerticalScroll -int 1

print_line " - Natural trackpad scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
defaults write -g com.apple.swipescrolldirection -bool TRUE

print_line " - Force touch enabling"
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

print_line " - Dock on the left"
defaults write com.apple.dock 'orientation' -string 'left'

print_line " - Mission control: group by app"
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.dock expose-group-by-app -bool true

print_line " - Do not magnify apps on the dock"
defaults write com.apple.dock magnification -bool false

print_line " - Smallify stuff on the dock"
defaults write com.apple.dock tilesize -int 34

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Mission Control
print_line " - Hot corner settings"
# Top left screen corner
defaults write com.apple.dock wvous-tl-corner   -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner
defaults write com.apple.dock wvous-tr-corner   -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner
defaults write com.apple.dock wvous-bl-corner   -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner
defaults write com.apple.dock wvous-br-corner   -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

print_line " - Expand save panels by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

print_line " - No more resume"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

print_line " - Password required after screensaver"
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 0

print_line " - Go away Siri"
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

print_line " - Give me the volume feedback back"
defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool true

print_line " - Enable Safari development"
defaults write com.apple.Safari IncludeDevelopMenu -bool true

print_line " - Make desktop tolerable"
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

print_line " - Make finder tolerable"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarMediaBrowserSectionDisclosedState -bool true
defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarSharedSectionDisclosedState -bool true
defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarSharedSectionDisclosedState -bool true
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

print_line " - DS_Store, go away"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

print_line " - Battery percentage"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

print_line " - Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

print_line " - Don’t show recent applications in Dock"
defaults write com.apple.dock show-recents -bool false