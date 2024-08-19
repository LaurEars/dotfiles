# dotfiles
Personal settings files

### Steps
- [ ] [Generate new ssh key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [ ] [Add new ssh key to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- [ ] Install xcode: `xcode xcode-select --install`
- [ ] Clone `dotfiles` repo: `git clone git@github.com:LaurEars/dotfiles.git`
- [ ] Run `./setup.sh` from current directory
- [ ] Install [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)

### Other helpful configuration settings
Quad-click select in iTerm2: Under Settings > Profiles > Advanced > SmartSelection
- [ ] `file_path:line_number` regex: `[\w/]+\.\w+:\d+`
- [ ] To match a file path in a git diff output, set this to higher precision so it matches preferentially to standard path regex without `a/` or `b/` prefixes: `(?<=[ab]\/)([\w/]+\.\w+)`
