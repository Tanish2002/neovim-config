{
  description = "Neovim Config flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nixvim = {
    # url = "github:pta2002/nixvim";
    url = "git+file:/home/weeb/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      module = {imports = [./config];};
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      nixvim' = nixvim.legacyPackages."${system}";
      nvim = nixvim'.makeNixvimWithModule {inherit module pkgs;};
    in {
      packages = {
        inherit nvim;
        default = nvim;
      };
    });
}
