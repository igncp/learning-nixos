# https://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz
# https://nixos.org/guides/nix-pills/generic-builders.html

export PATH="$gnutar/bin:$gcc/bin:$gnumake/bin:$coreutils/bin:$gawk/bin:$gzip/bin:$gnugrep/bin:$gnused/bin:$binutils/bin"
tar -xzf $src
cd hello-2.10
./configure --prefix=$out
make
make install
