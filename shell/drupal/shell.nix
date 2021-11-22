# originally https://github.com/loophp/nix-shell/blob/master/resources/dev/common.nix

{ pkgs ? (import <nixpkgs> { })
, nix-phps ? import (fetchTarball https://github.com/fossar/nix-phps/archive/49fea59ae5ae634ee8b38e89ddd22b3dd9f49176.tar.gz)
, version ? "php80"
, phpIni ? ''
    max_execution_time = 0
    xdebug.mode=debug
    memory_limit=-1
  ''
, phpExtensions ? { all, ... }: with all; [
    filter
    iconv
    ctype
    redis
    tokenizer
    simplexml

    dom
    posix
    intl
    opcache

    calendar
    curl
    exif
    fileinfo
    gd
    mbstring
    openssl
    pcov
    pdo_sqlite
    pdo_mysql
    pdo_pgsql
    soap
    sqlite3
    xdebug
    xmlreader
    xmlwriter
    zip
    zlib
  ]
}:

let
  phpOverride = nix-phps.packages.${builtins.currentSystem}.${version}.buildEnv {
    extensions = phpExtensions;
    extraConfig = phpIni;
  };

in
pkgs.mkShell {
  name = "php-" + phpOverride.version;

  buildInputs = [
    phpOverride
    phpOverride.packages.composer

    pkgs.git
    pkgs.docker-compose
    pkgs.gnumake
    pkgs.mysql
  ];
}
