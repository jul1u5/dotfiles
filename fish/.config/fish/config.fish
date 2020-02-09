if type -q direnv
  direnv hook fish | source
end

if type -q any-nix-shell
  any-nix-shell fish --info-right | source
end

if type -q starship
  eval (starship init fish)
end
