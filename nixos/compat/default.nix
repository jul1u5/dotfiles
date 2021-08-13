let
  lock = builtins.fromJSON (builtins.readFile ../flake.lock);

  flake-compat = with lock.nodes.flake-compat.locked; fetchTarball {
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
    sha256 = narHash;
  };
in
import flake-compat {
  src = ../.;
}
