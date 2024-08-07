
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=./node_modules/.bin:$PATH
export PGDATA=/usr/local/var/postgres

export GOPATH=$HOME/gowork
export PATH=$PATH:$GOPATH/bin

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# Require virtualenv when doing pip install
export PIP_REQUIRE_VIRTUALENV=true

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Aliases
# For docker
alias 'docker-env'='eval "$(docker-machine env default)"; docker-machine env default'
# For fun
alias 'chmod-yolo'='chmod 777'
# For python
alias 'pycache-clean'='find . | grep -E "(__pycache__|\.pyc$)" | xargs rm -rf'
alias 'pep8'='autopep8 --in-place --max-line-length 120'
export PYTHONBREAKPOINT=ipdb.set_trace
# frequently used git commands
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
if [`git ls-files -u >& /dev/null` -eq '']
then
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
fi
echo -n $git_prompt_info
}

function __pyenv_prompt_info {
if [ ! -z $PYENV_VERSION ]
then
  pyenv_prompt_prefix="($PYENV_VERSION) "
else
  pyenv_prompt_prefix=""
fi
echo -n $pyenv_prompt_prefix
}

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
PROMPT='$(__pyenv_prompt_info)%{$(basename $(pwd))%} $fg_bold[blue] [$(__git_prompt_info)$fg_bold[blue]]$reset_color
$ %}'

source ~/.local_secrets.sh
source ~/.iterm2_shell_integration.zsh

# To set iterm badge to \(user.gitRepo) to get git repo name as badge
iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var gitRepo $((git config --local remote.origin.url 2> /dev/null | sed -n 's#.*/\([^.]*\)\.git#\1#p' 2> /dev/null))
}
