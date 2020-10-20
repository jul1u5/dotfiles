{
  outputs = { self, nixpkgs }: {
    nixosConfiguration.spin = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
