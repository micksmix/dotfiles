# Dotfiles

This repository configures my preferred development environment on macOS and Debian-based Linux distributions. On macOS it installs Homebrew, taps the packages defined in `lists/brew-*`, and applies the macOS defaults I use day-to-day. On Linux it relies on the native package manager (`apt`) to install a comparable toolchain defined in `lists/apt-packages`.

## Installation
Run `./install.sh`

The installer automatically detects whether it is running on macOS or a Debian-based Linux distribution (Ubuntu 22.04 or newer is the primary target) and runs the appropriate setup steps. On Linux Homebrew is skipped in favour of native packages installed with `apt`.

On macOS, once complete open iTerm2:
- `Preferences` > `Profiles` > `Text` and select `Fira Code` and size `14`
- `Preferences` > `Profiles` > `Colors` and find `Color Presets...` in bottom-right corner and then import `init/monokai-pro-filtered.itermcolors`.

Notably absent are a few packages, because I don't always install them:
 - `brew install docker`
 - `brew install --cask burp-suite`

If you only want to install homebrew packages, run: 
```
./scripts/install-homebrew.sh
./scripts/install-homebrew-packages.sh
```

The homebrew packages to be installed are in text files under `./lists/`

For Debian-based Linux distributions you can run just the package installation step with:
```
./scripts/install-apt-packages.sh
```
The packages that will be installed are listed in `./lists/apt-packages`.

To add `open-in-code` to finder, [check their repo](https://github.com/sozercan/OpenInCode). Note: [for Big Sur](https://apple.stackexchange.com/a/407166).

After everything completes, I restart the system, but a logoff may be sufficient.

## License
http://creativecommons.org/licenses/MIT
