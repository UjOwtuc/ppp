home=(${${${(f)"$(</etc/passwd)"}%:*}//:*:/:})
: ${HOME:=${home[(r)${LOGNAME}:*]#*:}}
unset home

if [[ -z "$HOME" ]]
then
	if [[ "${LOGNAME}" == "root" ]]
	then
		HOME="/root"
	else
		HOME="/home/${LOGNAME}"
	fi
	echo "guessing homedir: $HOME" >&2
fi
export HOME

[[ -r "/etc/profile" ]] && source "/etc/profile" 2>/dev/null

export PS1='%B%(1j,%F{yellow}%jj ,)%(!,%F{red},%F{green})[%D{%H:%M}] %(!,,%n@)%m %F{cyan}%(5~,%-2~...%2~,%4~) ${vcs_info_msg_0_}#%f%b '
export PS2='%B%(!,%F{red},%F{green})%_>%f%b '
export PS4='+%B%F{cyan}%N%f:%(!,%F{red},%F{green})%i>%f%b '
export RPS1=$'%B%(0?,%F{green},%F{red})%?%f%b'
export SPROMPT='zsh: korrigiere '%R' nach '%r'? ([Y]es/[N]o/[E]dit/[A]bort) '

export PATH="${HOME}/.bin:${PATH}"
#export CDPATH=.:..:$HOME
#export TMPDIR=$HOME/tmp
export COLORTERM=yes

export EDITOR=vim
export PAGER=less
export READNULLCMD=less
export BROWSER=lynx
export LESS="-RCM"
export LESSCOLOR="always"
[[ -e "${HOME}/.lesspipe.sh" ]] && export LESSOPEN="|${HOME}/.lesspipe.sh %s"

export $(LC_ALL="de_DE.UTF-8" locale)

export RSYNC_RSH="ssh"

export GROFF_NO_SGR="yes"
export LESS_TERMCAP_mb=$'\e[01;32m'	# begin blinking
export LESS_TERMCAP_md=$'\e[01;31m'	# begin bold
export LESS_TERMCAP_me=$'\e[0m'		# end mode
export LESS_TERMCAP_se=$'\e[0m'		# end standout-mode
export LESS_TERMCAP_so=$'\e[01;44;33m'	# begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'		# end underline
export LESS_TERMCAP_us=$'\e[01;32m'	# begin underline

DIRSTACKSIZE=30

HISTSIZE=20000
SAVEHIST=21000
HISTFILE=~/.zsh_history

# print timing information if a command consumes more than 10 cpu seconds (user + system)
REPORTTIME=10

export LD_LIBRARY_PATH=""

# manual autoload for vcs_info (suppress errors if not found)
vcs_info()
{
	if ! builtin autoload -XUz 2>/dev/null
	then
		vcs_info()
		{
			vcs_info_msg_0_='%F{red}vcs_info%f %F{cyan}'
		}
	fi
}

precmd()
{
	if [[ -z $(git ls-files --other --exclude-standard 2>/dev/null) ]]
	then
		zstyle ':vcs_info:*' formats '[%b%c%u%F{cyan}]'
	else
		zstyle ':vcs_info:*' formats '[%b%c%u%F{red}*%F{cyan}]'
	fi
	vcs_info
}

setopt \
   aliases \
NO_all_export \
   always_last_prompt \
NO_always_to_end \
   append_history \
NO_auto_cd \
   auto_continue \
   auto_list \
   auto_menu \
NO_auto_name_dirs \
   auto_param_keys \
   auto_param_slash \
   auto_pushd \
NO_auto_remove_slash \
NO_auto_resume \
   bad_pattern \
   bang_hist \
   bare_glob_qual \
NO_bash_auto_list \
   beep \
NO_bg_nice \
   brace_ccl \
   bsd_echo \
   case_glob \
   case_match \
NO_c_bases \
NO_cdable_vars \
NO_chase_dots \
NO_chase_links \
   check_jobs \
NO_clobber \
NO_combining_chars \
   complete_aliases \
   complete_in_word \
   correct \
   correct_all \
NO_c_precedences \
   csh_junkie_history \
NO_csh_junkie_loops \
NO_csh_junkie_quotes \
NO_csh_nullcmd \
NO_csh_null_glob \
   debug_before_cmd \
NO_dvorak \
   equals \
NO_err_exit \
NO_err_return \
   eval_lineno \
   extended_glob \
   extended_history \
NO_flow_control \
   function_argzero \
   glob \
   global_export \
   global_rcs \
NO_glob_assign \
   glob_complete \
NO_glob_dots \
   glob_subst \
   hash_cmds \
   hash_dirs \
   hash_list_all \
   hist_allow_clobber \
   hist_beep \
   hist_expire_dups_first \
   hist_fcntl_lock \
   hist_find_no_dups \
NO_hist_ignore_all_dups \
   hist_ignore_dups \
   hist_ignore_space \
NO_hist_no_functions \
NO_hist_no_store \
   hist_reduce_blanks \
   hist_save_by_copy \
NO_hist_save_no_dups \
   hist_subst_pattern \
   hist_verify \
   hup \
NO_ignore_braces \
NO_ignore_eof \
NO_inc_append_history \
   interactive_comments \
NO_ksh_arrays \
NO_ksh_autoload \
NO_ksh_glob \
NO_ksh_option_print \
NO_ksh_typeset \
NO_ksh_zero_subscript \
NO_list_ambiguous \
NO_list_beep \
NO_list_packed \
NO_list_rows_first \
   list_types \
   long_list_jobs \
   magic_equal_subst \
NO_mail_warning \
   mark_dirs \
NO_menu_complete \
   multibyte \
NO_multi_func_def \
   multios \
NO_nomatch \
   notify \
NO_null_glob \
   numeric_glob_sort \
NO_octal_zeroes \
NO_overstrike \
   path_dirs \
   posix_builtins \
NO_print_eight_bit \
NO_print_exit_value \
NO_prompt_bang \
NO_prompt_cr \
   prompt_percent \
   prompt_sp \
   prompt_subst \
   pushd_ignore_dups \
NO_pushd_minus \
NO_pushd_silent \
   pushd_to_home \
NO_rc_expand_param \
NO_rc_quotes \
   rcs \
NO_rec_exact \
NO_rm_star_silent \
NO_rm_star_wait \
NO_share_history \
NO_sh_file_expansion \
NO_sh_glob \
NO_sh_nullcmd \
NO_sh_option_letters \
   short_loops \
NO_sh_word_split \
NO_single_line_zle \
NO_sun_keyboard_hack \
NO_transient_rprompt \
NO_traps_async \
NO_typeset_silent \
   unset \
NO_verbose \
NO_warn_create_global \
NO_xtrace \
   zle 2>/dev/null

[[ -e "${MODULE_PATH}/zsh/pcre.sh" ]] && setopt rematch_pcre

# get system colors for files (ls)
[[ -z "$SHELL" ]] && export SHELL='zsh'
eval $(dircolors)

alias j='jobs -l'
alias px='ps ax'
alias d='dirs -v'
alias dotstatus='vcsh foreach status --untracked-files=no --short'

export PS_FORMAT="euser,pid,ppid,tty,stat,start_time,command"

# prefer htop over top
whence htop >/dev/null && alias top=htop

# use batcat if available
whence batcat >/dev/null && alias cat="batcat"
export BAT_STYLE=grid

alias vi="vim"

# global aliases are substituted anywhere in the command line (cmd L => cmd | less)
alias -g L='| less'
alias -g V='| vim -c "set bt=nofile" -'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g C='| column -t'

# add colors to ls if possible
if ls --color -d / >/dev/null 2>&1
then
	alias ls='ls --color=auto'
fi

alias la='ls -a'
alias ll='ls -lh'
alias lsd='ls -d'
alias lad='ls -ad'
alias lld='ls -lhd'
alias lla='ls -lah'
alias llad='ls -lahd'
alias llatr='ls -latrh'
alias sl=ls
alias dc=cd

alias grep='grep --color=auto'
export GREP_COLOR='96'

alias myip='curl --silent http://checkip.dyndns.org | sed "s/^.*[[:space:]]\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\)[^0-9].*$/\1/"'

alias  __='$EDITOR ~/.zshrc'
alias ___='source  ~/.zshrc'

autoload -U zargs
autoload -U compinit ; compinit
zmodload -i zsh/complist

alias t='task'
compdef _task t

# vared for functions and aliases
aliased () { vared aliases[$1]; }
compdef _aliases aliased
funced () { vared functions[$1]; }
compdef _functions funced

# edit current command line in $EDITOR
# temporary fix thanks to  Mikael Magnusson
emulate zsh -c 'autoload -U edit-command-line'
zle -N edit-command-line
bindkey -a 'v' edit-command-line

insert-while() { LBUFFER="while $LBUFFER; do "; }
insert-for() { LBUFFER="for i in \$($LBUFFER); do "; }
get-help()
{
	local cmd="${BUFFER[(w)1]}"
	zle push-line
	BUFFER=" ${cmd} --help"
	zle accept-line
}
insert-date() { LBUFFER+="$(date +%F)" }

zle -N insert-while
zle -N insert-for
zle -N get-help
zle -N insert-date
bindkey -v '^E' push-line
bindkey -v '^B' up-line-or-search
bindkey -v '^F' down-line-or-search
bindkey -v '^Xd' insert-date
bindkey -v '^Xf' insert-for
bindkey -v '^Xo' expand-or-complete
bindkey -v '^Xq' get-help
bindkey -v '^Xw' insert-while

bindkey -v '^R' history-incremental-search-backward
bindkey -v '^O' accept-and-hold
bindkey -v '^[t' transpose-words
bindkey -v '^[u' up-case-word
bindkey -v '^[l' down-case-word
bindkey -v '^[.' insert-last-word
bindkey -M viins "^?" backward-delete-char

# backspace to exit menuselect and restore previous contents
bindkey -M menuselect '^?' send-break

# cursor bindings (copied from Debian's /etc/zsh/zshrc)
zmodload zsh/terminfo
[[ -z "$terminfo[cuu1]" ]] || bindkey -v "$terminfo[cuu1]" up-line-or-search
[[ -z "$terminfo[kcuu1]" ]] || bindkey -v "$terminfo[kcuu1]" up-line-or-search
[[ "$terminfo[kcuu1]" == $'\e'* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-search
[[ -z "$terminfo[cud1]" ]] || bindkey -v "$terminfo[cud1]" down-line-or-search
[[ -z "$terminfo[kcud1]" ]] || bindkey -v "$terminfo[kcud1]" down-line-or-search
[[ "$terminfo[kcud1]" == $'\e'* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-search

# vcs_info
zstyle ':vcs_info:*' actionformats '[%F{red}%b:a%F{cyan}]'
zstyle ':vcs_info:*' stagedstr '%F{green}*'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}*'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b:%r'
zstyle ':vcs_info:*' enable git

# complete current word from history (thanks to Julius Plenz)
zle -C hist-complete complete-word _generic
zstyle ':completion:hist-complete:*' completer _history
zstyle ':completion:hist-complete:*' remove-all-dups yes
bindkey '^N' hist-complete
bindkey '^@' hist-complete

zstyle ':completion:*:correct:*' insert-unambiguous true # RTFM :P
zstyle ':completion:*' completer _complete _prefix _approximate _ignored

# Globbing
zstyle ':completion:*' glob true

zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache yes
zstyle ':completion::complete:*' rehash true

# formatting
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*' group-name ''

# _approximate completer configuration
#zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle -e ':completion:*:approximate:*' max-errors '(( reply=($#PREFIX+$#SUFFIX)/3 ))'
zstyle -e ':completion:*:approximate-extreme:*' max-errors '(( reply=($#PREFIX+$#SUFFIX)/1.2 ))'
zstyle ':completion:*:(correct|approximate[^:]#):*' original true
zstyle ':completion:*:(correct|approximate[^:]#):*' tag-order 'corrections original'


# colorful completions
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# use the completion menu
zstyle ':completion:*' menu yes=long-list
zstyle ':completion:*' menu select=2

zstyle ':completion:*:ssh:*' group-order 'hosts' 'users'

# completin rm: first backup files, then bytecode, cores, all others at last
zstyle ':completion:*:*:rm:*' file-patterns '(*~|\\#*\\#):backup-files' '*.zwc:zsh\ bytecompiled\ files' 'core(|.*):core\ files' '*:all-files'

# completing wine: list .exe only
zstyle ':completion:*:*:wine:*' file-patterns '*.[Ee][Xx][Ee]:DOS\ executables' '*:all-files'

# kill
zstyle ':completion:*:kill:*' command 'ps xf -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:kill:*' insert-ids single
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# less und mutt: huge menu
zstyle ':completion:*:*:less:*' menu yes select
zstyle ':completion:*:*:mutt:*' menu yes select

# cd ..[Tab] => cd ../ but cd .[Tab] !=> cd ./
#zstyle ':completion::complete:*:*' ignored-patterns '.'
#zstyle ':completion::complete:*:*' accept-exact yes
zstyle ':completion:*:complete' ignore-parents pwd parent ..
zstyle -e ':completion:*' special-dirs 'reply=(..)'

_noargs() { _message "no more arguments"; }
compdef _noargs __ ___
compdef _man manopt

# = set -o vi
bindkey -v

# QuadKonsole4 sendInput
bindkey $'\n' accept-line

# special keys
bindkey '\e[1~' beginning-of-line
bindkey '\e[H' beginning-of-line
bindkey '^[OH' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[F' end-of-line
bindkey '\e[3~' delete-char
bindkey '\e[5~' beginning-of-history
bindkey '\e[6~' end-of-history
bindkey '\e[2~' insert-last-word

# vi motions for the completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# insert selected completion, keep the menu open and move to the next option
bindkey -M menuselect 'i' accept-and-menu-complete

# insert selected completion and use it as base for the next list
bindkey -M menuselect 'o' accept-and-infer-next-history

# host specific extra configuration
HOSTNAME="$(uname -n)"
[[ -f "/etc/zsh/zshrc.${HOSTNAME}" ]] && source "/etc/zsh/zshrc.${HOSTNAME}"
[[ -f "$HOME/.zshrc.${HOSTNAME}" ]] && source "$HOME/.zshrc.${HOSTNAME}"

umask 022

if [[ -d "${HOME}/.zautoload" ]]
then
	fpath=("${HOME}/.zautoload" $fpath)
	if [[ -n "${fpath[1]}/*(.N:t)" ]] || [[ -n "${fpath[1]}/*(@N:t)" ]]
	then
		autoload -U ${fpath[1]}/*(.N:t) ${fpath[1]}/*(@N:t)
	fi
fi

zle -N unix-filename-rubout
bindkey -v '^Xb' unix-filename-rubout

zle -C insert-all-matches complete-word _insert_all_matches
bindkey '^Xi' insert-all-matches

tmux_bin="$(whence tmux)"
if [[ -z "$IS_SCREEN" && -z "$IS_TMUX" && -x "${tmux_bin}" ]]
then
	if tmux has-session 2>/dev/null
	then
		tmux attach-session
	fi
fi
unset tmux_bin
unset HOSTNAME

if [[ -e /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]
then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	export ZSH_HIGHLIGHT_STYLES[globbing]=fg=cyan,bold
	export ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=cyan
fi

