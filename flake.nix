# Buildgnoot - nix flake
# Copyright (C) 2026 Filip Kokosiński
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

{
  description = "Buildgnoot nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with self.packages.${system}; with pkgs; [
          autoconf
          automake
          automake116x
          (automake.overrideAttrs (
            final: _prev: {
              version = "1.17";
              src = pkgs.fetchurl {
                url = "mirror://gnu/automake/automake-${final.version}.tar.xz";
                hash = "sha256-iSDB/EEeE7kL9wTvnbbynVQOdtIyyzssn03EzFmb2ZA=";
              };
            }   
          ))
          (automake.overrideAttrs (
            final: _prev: {
              version = "1.18";
              src = pkgs.fetchurl {
                url = "mirror://gnu/automake/automake-${final.version}.tar.xz";
                hash = "sha256-W9zMqWsAen40TCQgS5uawS7NF/WXGTGpBjve5Ih/Sq8=";
              };
            }   
          ))
          binutils
          bison
          fakeroot
          fig2dev
          flex
          gcc
          gettext
          git
          gmp.dev
          gnumake
          grub2
          kconfig-frontends
          libmpc
          libtool
          meson
          mpfr.dev
          ncurses
          ninja
          parted
          pkg-config
          python3
          qemu
          wget
          xorriso
          zlib
        ];

        hardeningDisable = [ "all" ];

        shellHook = ''
          export PATH="$(pwd)/.install/bg-toolchain-0.1.0/x86_64-gnu/bin:$PATH"
        '';
      };
    };
}
