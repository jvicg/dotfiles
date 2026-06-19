# fish/functions/ex.fish
# ex - one command for any archive type, accepts multiple files

function ex --description "Extract multiple filetypes with a single command"
  if test (count $argv) -eq 0
    echo "usage: ex FILE [FILE ...]"
    return 1
  end

  for file in $argv
    if not test -e $file
      echo "error: '$file' is not a valid file"
      continue
    end

    switch $file
      case '*.tar.gz' '*.tgz'  ; tar xzf $file
      case '*.tar.bz2' '*.tbz2'; tar xjf $file
      case '*.tar.xz' '*.txz'  ; tar xJf $file
      case '*.tar.zst'         ; tar --zstd -xf $file
      case '*.tar'             ; tar xf $file
      case '*.zip'             ; unzip $file
      case '*.7z'              ; 7z x $file
      case '*.rar'             ; unrar x -ad $file
      case '*.gz'              ; gunzip $file
      case '*.bz2'             ; bunzip2 $file
      case '*.xz'              ; unxz $file
      case '*.zst'             ; unzstd $file
      case '*.deb'             ; ar x $file
      case '*'                 ; echo "error: unknown format for file: '$file'"
    end
  end
end

