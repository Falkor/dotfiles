#compdef git-subtree
#description mange subtree paths

__git_subtree() {

local curcontext=$curcontext state line ret=1
declare -A opt_args

_arguments -C \
  '(-h --help)'{-h,--help}'[show the help]' \
  '-q[quiet command output]' \
  '-d[show debug messages]' \
  ': :->command' \
  '*:: :->option-or-argument' && ret=0

case $state in
  (command)
    declare -a commands

    commands=(
      'add:add a new subtree'
      'merge:merge remote refspec into prefix'
      'pull:fetch remote refspec and merge'
      'push:push local changes to remote refspec'
      'split:separate local subtree into separate branch')

    _describe -t commands command commands && ret=0
    ;;
  (option-or-argument)
    curcontext=${curcontext%:*}-$line[1]:

    case $line[1] in
      (add|merge|pull|push)
        _arguments -w -S -s \
          '--squash[merge subtree changes as a single commit]' \
          '(-P,--prefix)'{-P,--prefix=}'[path to the subdirectory]:subtree path:_directories -r ""' \
          '(-m,--message)'{-m,--message=}'[commit message for the merge]' \
          ':repository:__git_any_repositories' \
          ':remote branch:__git_remotes' && ret=0
        ;;
      (split)
        _arguments -w -S -s \
          '--annotate=[add message as annotation to each commit]' \
          '(-b,--branch)'{-b,--branch=}'[name of branch to contain new history]: :__git_local_branch_names' \
          '(-P,--prefix)'{-P,--prefix=}'[path to the subdirectory]:subtree path:_directories -r ""' \
          '--ignore-joins[force regeneration of entire history, skips rejoin points]' \
          '--onto=[commit id of first revision of subproject history]: :__git_tree_ishs' \
          '--rejoin[merge newly created history back into main project]' && ret=0
        ;;
    esac
    ;;
esac

return ret

}
# vim: set ft=zsh:
