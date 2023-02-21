{
  description = "Neovim Config flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nixvim = {
    url = "github:pta2002/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, nixvim, flake-utils, }:
    let config = import ./config { pkgs = nixpkgs; };
    in flake-utils.lib.eachDefaultSystem (system:
      let
        module = { imports = [ ./config ]; };
        pkgs = import nixpkgs { inherit system; };
        nixvim' = nixvim.legacyPackages."${system}";
        nvim = nixvim'.makeNixvimWithModule { inherit module pkgs; };
      in {
        packages = {
          inherit nvim;
          default = nvim;
        };
      });
}
