alias cat="bat"
alias g="git"
alias ll="ls -oAhG"
alias now='date +"%A %d %B %H:%M"'
alias sup='echo $(now) "$(weather)" $(battery)'
alias todo="git diff --name-only origin/master | xargs ag TODO"
alias weather='curl -s wttr.in?format="%c%20%20%t%20%m"'

# prefer Homebrewed vim over Apple default
# (at the moment, mostly for `conceal` features)
alias vi=/usr/local/bin/vim
alias vim=/usr/local/bin/vim
