#!/usr/bin/env zsh

# man zshoptions
setopt NO_all_export
setopt always_last_prompt
setopt NO_always_to_end
setopt append_history	# don't overwrite history
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt NO_auto_name_dirs
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt auto_remove_slash
setopt NO_auto_resume
setopt bad_pattern
setopt bang_hist
setopt NO_beep
setopt NO_brace_ccl
setopt NO_bsd_echo
setopt cdable_vars
setopt NO_chase_links
setopt NO_clobber
setopt complete_aliases
setopt complete_in_word
setopt correct_all
setopt NO_correct
setopt correct_all
setopt csh_junkie_history
setopt NO_csh_junkie_loops
setopt NO_csh_junkie_quotes
setopt NO_csh_null_glob
setopt equals
setopt extended_glob
setopt extended_history
setopt function_argzero
setopt glob
setopt NO_glob_assign
setopt glob_complete
setopt NO_glob_dots
setopt glob_subst
setopt hash_cmds
setopt hash_dirs
setopt hash_list_all
setopt hist_allow_clobber
setopt hist_beep
setopt hist_ignore_dups
setopt hist_ignore_space
setopt NO_hist_no_store
setopt hist_verify
setopt NO_ignore_braces
setopt NO_ignore_eof
setopt interactive_comments
setopt NO_list_ambiguous
setopt NO_list_beep
setopt list_types
setopt long_list_jobs
setopt nocheckjobs             # don't warn me about bg processes when exiting
setopt nohup                   # and don't kill them, either
setopt magic_equal_subst
setopt NO_mail_warning
setopt NO_mark_dirs
setopt NO_menu_complete
setopt multios
setopt nomatch
setopt notify
setopt NO_null_glob
setopt numeric_glob_sort
setopt NO_overstrike
setopt path_dirs
setopt posix_builtins
setopt NO_print_exit_value
setopt NO_prompt_cr
setopt prompt_subst
setopt pushd_ignore_dups
setopt NO_pushd_minus
setopt pushd_silent
setopt pushd_to_home
setopt rc_expand_param
setopt NO_rc_quotes
setopt NO_rm_star_silent
setopt NO_sh_file_expansion
setopt sh_option_letters
setopt short_loops
setopt NO_sh_word_split
setopt NO_single_line_zle
setopt NO_sun_keyboard_hack
setopt NO_verbose
setopt zle
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt NO_hist_no_functions
setopt NO_hist_save_no_dups
setopt inc_append_history
setopt share_history
setopt list_packed
setopt NO_rm_star_wait
setopt hist_reduce_blanks
# }}}

# {{{ Environment

#Choose word delimiter characters in line editor
WORDCHARS=''

# Save a large history
export HISTFILE=~/.zshhistory
HISTSIZE=3000
SAVEHIST=3000

# Maximum size of completion listing
LISTMAX=1000  # "Never" ask

# Dateien mit dem Befehl "< datei" unter less angucken
READNULLCMD=less

# Set up new advanced completion system
autoload -U compinit
compinit

# Common usernames
users=( gogo root )
zstyle ':completion:*' users $users

# Common hostnames
[ -f ~/.ssh/config ] && : ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}}
zstyle ':completion:*:*:*' hosts $ssh_config_hosts $ssh_known_hosts

# ls aliases
# ls in FreeBSD http://freebsd-node.de/Farbiges_ls
if [ $(uname) = "Darwin" ]; then alias ls='ls -G'; else alias ls='ls --color=auto'; fi
alias l='ls -lh'
alias ll='ls -l'

# File management/navigation
alias d='dirs -v'

# Renaming
#autoload zmv
#alias mmv='noglob zmv -W'

# find based on file extension
fext () {
  suffix="$1"
  shift
  find . -name "*.$suffix" "$@"
}

# Job/process control
alias j='jobs -l'

# No spelling correction
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'

# Global aliases
# WARNING: global aliases are evil.  Use with caution.
alias -g L='| less'
alias -g G='| egrep'

# suffix aliases
alias -s c=gvim
alias -s cpp=gvim
alias -s h=gvim

alias be='bundle exec'

# Key bindings 

bindkey -e

# fix keybindings
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# Prompt
autoload -U promptinit
promptinit
prompt suse

RPROMPT=%n

# Show the Current Command in the xterm Title Bar (zsh)
case $TERM in
    xterm*)
    preexec () {print -Pn "\e]0;%n@%m [$1] [%~]\a"}
    ;;
esac

export EDITOR=vim

export PATH=~/homebrew/bin/:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
