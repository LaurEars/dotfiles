# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# PostgreSQL data directory (checks both Intel and ARM Mac locations)
if [[ -d /opt/homebrew/var/postgres ]]; then
  export PGDATA=/opt/homebrew/var/postgres
elif [[ -d /usr/local/var/postgres ]]; then
  export PGDATA=/usr/local/var/postgres
fi

# On Apple Silicon Macs (M1, M2, etc), Homebrew installs to /opt/homebrew instead of /usr/local
# This adds brew commands to PATH
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add ~/.local/bin to PATH for locally installed tools
export PATH="$HOME/.local/bin:$PATH"

# Python configuration
# Require virtualenv when doing pip install
export PIP_REQUIRE_VIRTUALENV=true
# Use ipdb for breakpoints (requires ipdb)
export PYTHONBREAKPOINT=ipdb.set_trace

# Aliases
# For fun
alias 'chmod-yolo'='chmod 777'
alias 'git-lfg'='git push origin main --force-with-lease'
# For python
alias 'pycache-clean'='find . -type f -name "*.pyc" -delete && find . -type d -name "__pycache__" -delete'
alias 'pep8'='autopep8 --in-place --max-line-length 120'
# Frequently used git commands
alias 'git-fixup'='git commit --amend --no-edit'

# set base64 encode/decode functions for Mac OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Takes contents of clipboard, base64 encodes it, and pipes the encoded contents to clipboard
  alias b64e="pbpaste | base64 | pbcopy"

  # Takes contents of clipboard, base64 decodes it, and pipes the decoded contents to clipboard
  alias b64d="pbpaste | base64 --decode | pbcopy"
fi

# git autocompletion
autoload -Uz compinit && compinit

# Customizing the shell
setopt PROMPT_SUBST
autoload -U colors && colors
 
GIT_PROMPT_CLEAN="✔"
GIT_PROMPT_DIRTY="✗"
function __git_prompt_info {
  REPO_NAME=$(basename $(git rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)
  BRANCH_NAME=$(git name-rev --name-only --no-undefined --always HEAD 2> /dev/null)
  if [[ -n $BRANCH_NAME ]]; then
    echo -n $BRANCH_NAME
    echo -n " "
  fi
  if command git diff-index --quiet HEAD 2> /dev/null; then
    git_prompt_info=$fg_bold[green]$GIT_PROMPT_CLEAN
  elif [[ -n $REPO_NAME ]]; then
    git_prompt_info=$fg_bold[red]$GIT_PROMPT_DIRTY
  else
    git_prompt_info="~"
  fi
  echo -n $git_prompt_info
}

PROMPT='%{$(basename $(pwd))%} $fg_bold[blue] [$(__git_prompt_info)$fg_bold[blue]]$reset_color
$ %}'

# Load local secrets if file exists
if [[ -f ~/.local_secrets.sh ]]; then
  source ~/.local_secrets.sh
fi

# Enable iTerm2 shell integration if installed
if [[ -f ~/.iterm2_shell_integration.zsh ]]; then
  source ~/.iterm2_shell_integration.zsh
fi

# To set iterm badge to \(user.gitRepo) to get git repo name as badge
iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var gitRepo $((git config --local remote.origin.url 2> /dev/null | sed -n 's#.*/\([^.]*\)\.git#\1#p' 2> /dev/null))
}

