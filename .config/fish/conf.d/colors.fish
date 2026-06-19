# fish/conf.d/colors.fish
# custom fish syntax highlighting colors
#
# notes:
# - `--global` stores these variables globally for the current fish session.
# - `--reverse` swaps foreground/background.
# - `--background=color` sets the background color.

# -----------------------------
# core command-line highlighting
# -----------------------------

set --global fish_color_normal --bold normal                 # default text color
set --global fish_color_command --bold normal                # commands: ls, git, pacman, systemctl
set --global fish_color_param --bold normal                  # arguments/parameters: -la, /tmp, file.txt
set --global fish_color_error red                            # syntax errors / invalid commands
set --global fish_color_autosuggestion 7d7d7d                # autosuggestions shown while typing
set --global fish_color_redirection --bold brwhite           # redirections: >, >>, 2>, <
set --global fish_color_end afafff                           # command separators: ;, &, |
set --global fish_color_operator white                       # operators: &&, ||, command substitutions
set --global fish_color_escape brcyan                        # escaped characters: \n, \t, escaped spaces
set --global fish_color_quote afd787                         # quoted strings
set --global fish_color_comment 808080                       # comments: # comment
set --global fish_color_option                               # options/flags; empty = default
set --global fish_color_keyword                              # keywords: if, else, for, while, function


# -----------------------------
# paths and prompt-related colors
# -----------------------------

set --global fish_color_valid_path --underline               # valid filesystem paths
set --global fish_color_cwd green                            # current directory in prompt
set --global fish_color_cwd_root red                         # current directory when root
set --global fish_color_user brgreen                         # username in prompt
set --global fish_color_host normal                          # hostname in prompt
set --global fish_color_host_remote                          # hostname over ssh; empty = default
set --global fish_color_status ff6c6b                        # exit status / status indicator


# -----------------------------
# search, selection and history
# -----------------------------

set --global fish_color_search_match white --background=brblack      # search/history match
set --global fish_color_selection white --bold --background=brblack  # selected text
set --global fish_color_history_current --bold                       # current history item
set --global fish_color_cancel --reverse                             # cancelled command, e.g. ctrl+c


# -----------------------------
# completion pager colors
# -----------------------------

set --global fish_pager_color_background                             # pager background; empty = default
set --global fish_pager_color_completion normal                      # completion candidate text
set --global fish_pager_color_description yellow --italics           # completion descriptions
set --global fish_pager_color_prefix normal --bold --underline       # matching prefix
set --global fish_pager_color_progress brwhite --background=cyan     # pager progress indicator


# -----------------------------
# secondary pager colors
# -----------------------------

set --global fish_pager_color_secondary_background           # secondary row background
set --global fish_pager_color_secondary_completion           # secondary completion text
set --global fish_pager_color_secondary_description          # secondary description text
set --global fish_pager_color_secondary_prefix               # secondary matching prefix


# -----------------------------
# selected pager item colors
# -----------------------------

set --global fish_pager_color_selected_background --reverse  # selected completion row
set --global fish_pager_color_selected_completion            # selected completion text
set --global fish_pager_color_selected_description           # selected description text
set --global fish_pager_color_selected_prefix                # selected matching prefix

