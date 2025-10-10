# Bash Aliases


# The changes made in the .bashrc or .bash_profile files take effect
# the next time you open a new shell or terminal session.

# You can also run the "source" command followed by the file name
# to apply the changes immediately.

# Like this – source .bashrc


# Homebrew related
# ================

alias b-l='brew list -l'
alias b-cln='brew cleanup'
alias b-doc='brew doctor'
alias b-out='brew outdated'
alias b-upd='brew update'
alias b-upg='brew upgrade'


# Node.js related
# ===============

alias n-v='node -v'
alias n-l='npm list --depth=0'
alias n-lg='npm list -g --depth=0'
alias n-rb='npm run build'
alias n-rd='npm run dev'
alias n-rt='npm run test'


# ===================
# File system related
# ===================


# File system listing
# ===================

alias l='ls -G'
alias ll='ls -lG'
alias la='ls -alG'


# File system navigation
# ======================

alias r='cd /'
alias h='cd ~'
alias u='cd ..'


# Misc. / Untilities
# ==================

# Vim
alias v='vim'
alias sv='sudo vim'

# Joshuto
alias jo='cd ~ && joshuto'

# Serve the folder
alias serve='http-server .'

# Check available shells
alias shells='cat /etc/shells'

# Get your ip address
alias ip='ipconfig getifaddr en0' # or en1, depending on your Mac and your connection
