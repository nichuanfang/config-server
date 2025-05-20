#自定义别名
alias ...='cd ../../'
alias ..='cd ../'
alias .='ls'
alias ~='cd ~'
alias ud='docker-compose down && docker-compose pull && docker-compose up -d && docker image prune -af'
alias gp='git pull --rebase --autostash'

cd() {
    builtin cd "$@" && ls
}

#配置sftp
export PS1="$PS1\[\e]1337;CurrentDir="'$(pwd)\a\]'
