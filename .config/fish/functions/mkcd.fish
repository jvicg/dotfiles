# fish/functions/mkcd.fish
# mkcd - make dir and cd into it in one shot

function mkcd --argument dir --description "Create dir and cd into that dir"
    mkdir -p $dir && cd $dir
end
