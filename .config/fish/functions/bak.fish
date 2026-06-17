# ~/.config/fish/functions/bak.fish
# simple function to backup files
function bak --argument file --description "Create a bak file of given file"
    cp -v $file $file.bak
end

