export ZSH="$HOME/.oh-my-zsh"

# enjoy some flex :)
neofetch

# some ohmyzsh configs
ZSH_THEME="robbyrussell"
plugins=(git z)
source $ZSH/oh-my-zsh.sh

# fzf configs (dunno ask GPT)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden -g "!{node_modules/*,.git/*,vendor/,*.swp,*.swo}" --glob "!.{idea/*}"'
alias sd='fzf -m | xargs -I{} rg --fixed-strings --files-with-matches {} --hidden --glob "!.{yarn/**,rustup/**,vscode-server/**,cache/**}"'

# convenient move some level directory
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# Laravel + Docker = ❤️
alias sail='[ -f sail  ] && sh sail || sh vendor/bin/sail'

# idk some override the defaults
export EDITOR='vim'
export TERM=xterm-256color

# nvm auto generate post-install
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# some env variables
export PAT=
export DIGITAL_OCEAN_ACCESS_TOKEN=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export OPENAI_SECRET_KEY=

# some C aliases
alias cc="gcc -Wall -save-temps"
alias cpp="g++ -Wall -save-temps"
alias stdc="echo -e '#include <iostream>\n\nint main() {\n\tprintf(\"hello world\");\n\treturn 0;\n}'"

# some Github guide refer the pbcopy command but turns out it's only available on macOS
alias pbcopy='xsel --clipboard --input'

