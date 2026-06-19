# fish/functions/bak.fish
# bak - simple function to backup files

function bak --argument file --description "Create a bak file of given file"
    cp -v $file $file.bak
end

