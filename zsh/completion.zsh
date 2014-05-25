# Add custom completion scripts.
fpath=(~/.zsh/completion $fpath)

# Compsys initialization.
autoload -Uz compinit
compinit

# Show completion menu when number of options is at least 2.
zstyle ':completion:*' menu select=2
