function haskell-env --description 'create nix-shell with the specified haskell packages'
    argparse 'g-ghc=?!_validate_int' 'h-hoogle' 'p=+' -- $argv
    or return

    if set -q _flag_ghc
        set repo "haskell.packages.ghc"$_flag_ghc
    else
        set repo "haskellPackages"
    end

    if set -q _flag_hoogle
        set func "ghcWithHoogle"
    else
        set func "ghcWithPackages"
    end

    echo "repository: $repo"
    echo "packages: $_flag_p"

    nix-shell -p $repo"."$func" (pkgs: with pkgs; [ $_flag_p ])"
end

function python-env --description 'create nix-shell with the specified python packages'
    argparse 'v=?!_validate_int' 'p=+' -- $argv
    or return

    if set -q _flag_v
        set python_version $_flag_v
    else
        set python_version 3
    end

    echo "Python version: $python_version"
    echo "packages: $_flag_p"

    nix-shell -p "python"$python_version".withPackages (pkgs: with pkgs; [ $_flag_p ])"
end
