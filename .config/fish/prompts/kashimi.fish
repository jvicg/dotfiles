# fish/prompts/kashimi.fish
# slightly modified sashimi prompt (https://github.com/isacikgoz/sashimi)

function fish_prompt
  
  # declare colors and other vars
  set -l last_status $status
  set -l yellow (set_color -o yellow)
  set -g red (set_color -o ff6c6b)
  set -g blue (set_color -o a9b1d6)
  set -l green (set_color -o green)
  set -g normal (set_color -o normal)
  set -g fish_prompt_pwd_dir_length 0
  set -l ahead (_git_ahead)
  set -g whitespace ' '

  # manage last status
  if test $last_status = 0
    set initial_indicator "$blue "
    set status_indicator "$blue❯"
  else
    set initial_indicator "$blue "
    set status_indicator "$blue❯ $red$last_status"
  end
  set -l cwd $normal(prompt_pwd)

  # git info
  if [ (_git_branch_name) ]

    if test (_git_branch_name) = 'master'
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($red$git_branch$normal)"
    else
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($blue$git_branch$normal)"
    end

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end

  # notify if a command took more than 5 minutes
  if [ "$CMD_DURATION" -gt 300000 ]
    set seconds (math "$CMD_DURATION/1000")
    set formatted_seconds (printf "%.2f" $seconds)
    echo "fish: the last command took $formatted_seconds seconds"
  end

  # draw the prompt
  echo -n -s $initial_indicator $whitespace $cwd $git_info $whitespace $ahead $status_indicator $whitespace $normal
end

# function to check if local branch state compared to remote (upsteam)
function _git_ahead
  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
  if [ $status != 0 ]
    return
  end
  set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
  set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
  switch "$ahead $behind"
    case ''     # no upstream
    case '0 0'  # equal to upstream
      return
    case '* 0'  # ahead of upstream
      echo "$blue↑$normal_c$ahead$whitespace"
    case '0 *'  # behind upstream
      echo "$red↓$normal_c$behind$whitespace"
    case '*'    # diverged from upstream
      echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
  end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end

