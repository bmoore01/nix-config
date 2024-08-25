# fancy git branch selector using fzf
gch() {
    local branch=$(git branch | fzf-tmux -p60%,20% | tr -d '[:space:]|*')
    if [[ $branch ]]; then
        git checkout $branch
    fi
}


# fancy directory stack selector selector
for index ({1..9}) alias "$index"="cd +${index}"; unset index

fpop() {
    # Only work with alias d defined as:
    # for index ({1..9}) alias "$index"="cd +${index}"; unset index
    d | fzf-tmux -p60%,20% | cut -f 1 | source /dev/stdin
}

# Select directory inside $WORKSPACE/projects/
projects() {
    result=$(find $PROJECTS/* -type d -prune -exec basename {} ';' | sort | uniq | nl | fzf-tmux -p60%,20% | cut -f 2)
    [ -n "$result" ] && cd $PROJECTS/$result
}

# for existing man pages
mans() {
  apropos . | fzf --preview-window=up:50% --preview 'echo {} | cut -f 1 -d "(" | xargs man' | cut -f 1 -d "(" 
}

# find existing aliases
falias() {
  alias | tr = "\t" | fzf | cut -f 1
}


# search for a pattern, if you hit return will open in vim if you hit ctrl-i will open in intelliJ
search() {
    local IFS=:

    local selected=($(rg --color=always --line-number --no-heading --smart-case "$1" | \
        fzf-tmux -p80%,80% --ansi \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --reverse \
            --preview 'bat -n --color=always {1} --highlight-line {2}' \
            --bind 'ctrl-i:execute(echo INTELIJ:{1}:{2})+abort' \
            --bind 'enter:execute(echo VIM:{1}:{2})+abort' \
            --bind 'q:abort' \
            --preview-window 'bottom,60%,border-top,+{2}+3/3'))

    if [ -z ${selected[1]} ]; then
        return 0;
    fi

    if [[ ${selected[1]} == "INTELIJ" ]]; then 
        idea --line ${selected[3]} ${selected[2]}
    else
        vim  ${selected[2]} +${selected[3]} 
    fi
}
