
export PATH=./node_modules/.bin:$PATH
export PGDATA=/usr/local/var/postgres

export GOPATH=$HOME/gowork
export PATH=$PATH:$GOPATH/bin

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# VirtualEnv Stuff
VENVBURRITO="$HOME/.venvburrito"
VENVBURRITO_esc="$HOME/.venvburrito"
WORKON_HOME="~/.virtualenvs"

# startup virtualenv-burrito
if [ -f $VENVBURRITO_esc/startup.sh ]; then
    . $VENVBURRITO_esc/startup.sh
fi

# Aliases
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# For docker
alias 'docker-env'='eval "$(docker-machine env default)"; docker-machine env default'
# For fun
alias 'chmod-yolo'='chmod 777'

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
