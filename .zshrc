bindkey '\e[3~' delete-char # del
bindkey ';5D' backward-word # ctrl+left
bindkey ';5C' forward-word #ctrl+right

stty stop ''
ttyctl -f

autoload -U promptinit
promptinit
prompt bigfade brown

# Aliases
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias -s {avi,mpeg,mpg,mov,m2v}=mplayer
alias -s {odt,doc,sxw,rtf}=openoffice.org
autoload -U pick-web-browser
alias -s {html,htm}=chromium
alias TERM=xterm-256color micro
# человеческие df и du
alias df='show_which df && df -k --print-type --human-readable'
alias du='show_which du && du -k --total --human-readable'
# для цветного грепа
alias grep='grep --colour=auto'


#Включить автодополнение 
autoload -U compinit promptinit 
compinit
promptinit
# Для pacman
[[ -a $(whence -p pacman-color) ]] && compdef _pacman pacman-color=pacman
# Корректировка ввода
setopt CORRECT_ALL
# Если в слове есть ошибка, предложить исправить её
SPROMPT="Нет такой команды! Ввести %r вместо %R? ([Y]es,[N]o,[E]dit,[A]bort) "
# Не нужно всегда вводить cd
# просто наберите нужный каталог и окажитесь в нём
setopt autocd
# При совпадении первых букв слова вывести меню выбора
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#  History
# хранить историю в указанном файле
export HISTFILE=~/.zsh_history
# максимальное число команд, хранимых в сеансе
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
# включить историю команд
setopt APPEND_HISTORY
# убрать повторяющиеся команды, пустые строки и пр.
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# zsh-syntax-highlighting from AUR
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES=(
        'alias'           'fg=153,bold'
        'builtin'         'fg=153'
        'function'        'fg=166'
        'command'         'fg=153'
        'precommand'      'fg=153, underline'
        'hashed-commands' 'fg=153'
        'path'            'underline'
        'globbing'        'fg=166'
)

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Распаковка архивов
# example: extract file
extract () {
 if [ -f $1 ] ; then
 case $1 in
 *.tar.bz2)   tar xjf $1        ;;
 *.tar.gz)    tar xzf $1     ;;
 *.bz2)       bunzip2 $1       ;;
 *.rar)       unrar x $1     ;;
 *.gz)        gunzip $1     ;;
 *.tar)       tar xf $1        ;;
 *.tbz2)      tar xjf $1      ;;
 *.tbz)       tar -xjvf $1    ;;
 *.tgz)       tar xzf $1       ;;
 *.zip)       unzip $1     ;;
 *.Z)         uncompress $1  ;;
 *.7z)        7z x $1    ;;
 *)           echo "Я не знаю как распаковать, проверь файл '$1'..." ;;
 esac
 else
 echo "'$1' неправильный файл"
 fi
}

# замена less и zless на симпотяшный vimpager
alias less='vimpager'
alias zless='vimpager'

# Запаковать архив
# example: pk tar file
pk () {
 if [ $1 ] ; then
 case $1 in
 tbz)       tar cjvf $2.tar.bz2 $2      ;;
 tgz)       tar czvf $2.tar.gz  $2       ;;
 tar)      tar cpvf $2.tar  $2       ;;
 bz2)    bzip $2 ;;
 gz)        gzip -c -9 -n $2 > $2.gz ;;
 zip)       zip -r $2.zip $2   ;;
 7z)        7z a $2.7z $2    ;;
 *)         echo "'$1' не могу запаковать через pk()" ;;
 esac
 else
 echo "'$1' неправильный файл"
 fi

}
#virtualenv
export WORKON_HOME=$HOME/Project/virtenv
source /usr/bin/virtualenvwrapper.sh

#Прозрачность
#[ -n "$XTERM_VERSION"  ] && transset-df -a >/dev/null
