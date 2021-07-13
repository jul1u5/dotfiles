{ pkgs, ... }:

{
  user.packages = with pkgs; [
    xournalpp
  ];
}
