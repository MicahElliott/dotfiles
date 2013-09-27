# Source this to set the titlebar for long running jobs.
# E.g., test watcher, mongo/redis/brunch servers, nodemon
#
# Doing this here instead of in prompt due to printing bug where % is screwy.

preexec() { print -Pn '\e]0;$1 | %~\a' }
