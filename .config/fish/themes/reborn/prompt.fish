# fish/offwhite.fish - prompt
# modernized version of the standard bash prompt - with off white colors and git integration

function fish_prompt

  # components
  set -l last_status $status
  set -l cwd (prompt_pwd)
  set -l user $(whoami)
  set -l host $(uname -n)
  set -g whitespace ' '
  set git_branch_name (_git_branch_name)

  # colors
  set -l off_white (set_color fffddd)
  set -g red (set_color -o red)
  set -g green (set_color -o green)
  set -g normal (set_color normal)

  # check for errors in the last command
  if test $last_status = 0
    set initial_indicator ""
  else
    set initial_indicator " $red$last_status$normal"
  end

  # check if repository is dirty (not sync with remote)
  if [ (_git_branch_name) ]
    set initial_indicator "$normal(git$green✱$normal$git_branch_name)"
    if [ (_is_git_dirty) ]
    set initial_indicator "$normal(git$red≠$normal$git_branch_name)"
      set git_info "$git_info$dirty"
    end
  end

  # notify if a command took more than 5 minutes
  if [ "$CMD_DURATION" -gt 300000 ]
    set seconds (math "$CMD_DURATION/1000")
    set formatted_seconds (printf "%.2f" $seconds)
    echo "fish: the last command took $formatted_seconds seconds"
  end

  # draw prompt
  echo -n -s $off_white $host $normal " at " $cwd $off_white $initial_indicator $whitespace
end

# git integration functions
function _git_branch_name # checks if working dir is a git repository
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty # checks if git is not sync
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end
