# Bash Profile


# The changes made in the .bashrc or .bash_profile files take effect
# the next time you open a new shell or terminal session.

# You can also run the "source" command followed by the file name
# to apply the changes immediately.

# Like this – source .bash_profile

. ~/.bashrc


# Color for default macOS terminal app
# ====================================

export CLICOLOR=1


# Homebrew related
# ================

eval "$(/opt/homebrew/bin/brew shellenv)"


# Volta related
# =============

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
