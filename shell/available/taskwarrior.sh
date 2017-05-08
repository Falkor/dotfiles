# Specific configuration for TaskWarrior
# See https://taskwarrior.org/docs/configuration.html

if [ -n "$(which task 2>/dev/null)" ]; then
  export TASKRC=~/.taskrc
  export TASKDATA=~/.config/task
fi
