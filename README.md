# macOS dotfiles

Run `./install.sh`

Once complete, open iTerm2:
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

To add `open-in-code` to finder, [check their repo](https://github.com/sozercan/OpenInCode). Note: [for Big Sur](https://apple.stackexchange.com/a/407166).

After everything completes, I restart the system, but a logoff may be sufficient.