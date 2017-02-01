# Specific configuration for TaskWarrior
# See https://taskwarrior.org/docs/configuration.html

if [ -n "$(which task)" ]; then
  export TASKRC=~/.taskrc
  export TASKDATA=~/.config/task
fi
