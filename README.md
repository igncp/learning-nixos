# 30 Days of NixOS

This repository organizes my learnings about NixOS (and Nix), as an exercise to eventually consider whether to use it in my development environment. I start from scratch so most of the initial learnings will be the basic concepts and tools.

The goal is to spend at least 30 days learning Nix + NixOS, and then decide if it is worth to continue learning it, to start migrate to it from my existing Linux setup, or to leave the idea for now. Setting a minimum of 30 days because of the steep learning curve which makes it difficult to make an informed decision.

The idea is that the 30 days don't have to be consecutive although each learning day should be at most a few days apart from each other. I have to spend at least one hour for it to count as a day.

Days spent learning: 3/30

- https://nixos.org/

## Concepts

- Glossary of common terms: https://nixos.org/manual/nix/stable/glossary.html
- Flakes: https://nixos.wiki/wiki/Flakes
- Overlays: https://nixos.wiki/wiki/Overlays
- Module: https://nixos.wiki/wiki/Module
- NAR: Nix ARchive

## Current Setup

- Virtual Machine in VirtualBox
    - Setup the bridge network adapter
- https://nixos.org/manual/nixos/stable/index.html#sec-installation
- Installation steps:
    - `sudo passwd nixos` - to be able to SSH into it
    - At this point can ssh into the VM: `ssh nixos@192.168.1.X`
    - `sudo mount /dev/sda1 /mtn`
    - `sudo nixos-generate-config --root /mnt`
    - Update the config to point the bootloader into the installed device
    - `sudo nixos-install`
- Useful config:
    - Add user to sudoers: https://unix.stackexchange.com/a/498693
    - Enable SSH: `services.sshd.enable = true;`
    - First time you can login as root

## NixOS
    - `nixos-rebuild switch`
    - Upgrade: `nixos-rebuild switch --upgrade`
    - Find a value of an option: `nixos-option services.xserver.enable`

## Nix

- List dependencies: `nix-store -q --references /nix/store/z77vn965a59irqnrrjvbspiyl2rph0jp-hello.drv`
- Clear space: `nix-collect-garbage`
- Show a derivation: `nix show-derivation /nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv»`
- Build a derivation: `nix-store -r /nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv`
- Find path of binary: `readlink -f $(which git)`
- To synchronize the store between several machines: `nix-copy-closure`
- Search package: `nix search nodejs`
- Repl: `nix repl`
    - Show commands: `:?`
    - Load packages: `:l <nixpkgs>`
    - Start the repl with nixpkgs loaded: `nix repl '<nixpkgs>'`: useful to inspect attributes

### nix-shell

- Run an expression: `nix-shell -p 'python38.withPackages (packages: [ packages.django ])'`
- Run with packages: `nix-shell -p gitMinimal vim nano joe`
- Run a pure environment: `nix-shell --pure -p git -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/82b5f87fcc710a99c47c5ffe441589807a8202af.tar.gz`
    - The `--pure` flag means that then bash environment (e.g. editor) is not inherited, so normally is better without `--pure`
    - `-I` would pin the `git` version

### nix-env

- Install vim: `nix-env -i vim`
    - Install from unstable: `nix-env -iA unstable.neovim` 
- List installed packages in current profile: `nix-env --query "*"`
- Remove package from profile: `nix-env -e package_name`
- Generations:
    - Go to previous generation: `nix-env --rollback`
    - List generations: `nix-env --list-generations`
    - Go to specific generation: `nix-env --switch-generation number`

### nix-channel

- List existing channels: `nix-channel --list`
- Add unstable channel: `nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable`

### Home Manager

- A community tool to manage dotfiles for users with nix
- Repo: https://github.com/nix-community/home-manager
- Manual: https://nix-community.github.io/home-manager/#ch-usage
- The config is in `~/.config/nixpkgs/home.nix`
- `home-manager build`
- "The option names of a program module typically start with programs.<package name>."
- Options: https://rycee.gitlab.io/home-manager/options.html
- Modules:
    - zsh: https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix

## Env variables

- `$NIX_PATH`: Important variable, similar to `$PATH`: https://nixos.org/guides/nix-pills/nix-search-paths.html

## Misc

- "When a directory (by default the current directory) has a `default.nix`, that `default.nix` will be used (see import here). In fact you can run `nix-build -A hello` without specifying `default.nix`."
- Some configs are defined here: `/nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/config/`
- "Managing packages is mostly done with the `nix-env` command"
- Raspberry PI: https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi
- `-A` refers to "Attribute" in multiple commands like `nix-build` or `nix-env`)
- Conditionally use an environment variable: https://discourse.nixos.org/t/is-this-a-good-way-to-modularize-home-manager-home-nix-for-home-work/5817/5

## Resources

- Channels: https://channels.nixos.org/
- Nix manual: https://nixos.org/manual/nix/stable
- Nix Pills: https://nixos.org/guides/nix-pills/index.html
- Nix language summary: https://nixos.wiki/wiki/Nix_Expression_Language
- Package versions: https://lazamar.co.uk/nix-versions/
- Search for options: https://search.nixos.org/options
- Search for packages: https://search.nixos.org/packages
- Dependency management: https://github.com/nmattia/niv/

### Cheatsheets

- Official: https://nixos.wiki/wiki/Cheatsheet
- Third-party: https://github.com/brainrape/nixos-tutorial/blob/master/cheatsheet.md

### Real Configs

- https://github.com/mitchellh/nixos-config
- https://github.com/thomashoneyman/.dotfiles

### Tutorials

- https://nix.dev/
- Nix: https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/getting-started.html
- https://rgoswami.me/posts/ccon-tut-nix/
- Example of bundling a binary: https://discourse.nixos.org/t/how-to-install-github-released-binary/1328/5

### Repos

- nixpkgs: `git clone https://github.com/NixOS/nixpkgs.git --depth 1`
- nix: `git clone https://github.com/NixOS/nix.git --depth 1`

### Others

- Convert another distribution into NixOS: https://github.com/jeaye/nixos-in-place
