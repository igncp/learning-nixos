# Example of custom derivation
# For the sha256: First put a dummy one, try to build it, then replace it with
# the real one from the logs
{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "scc";
  version = "2.13.0";

  src = fetchFromGitHub {
    owner = "boyter";
    repo = "scc";
    rev = "v${version}";
    sha256 = "16p5g20n5jsbisbgikk9xny94xx6c0dxf19saa686ghh31jr2hh3";
  };

  vendorSha256 = null;

  # scc has a scripts/ sub-package that's for testing.
  excludedPackages = [ "scripts" ];

  meta = with lib; {
    homepage = "https://github.com/boyter/scc";
    description = "A very fast accurate code counter with complexity calculations and COCOMO estimates written in pure Go";
    platforms = platforms.unix;
  };
}
