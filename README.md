# Symbol

> A build tool for Standard ML

🚧 This project is unfinished and ongoing. Pardon our ~~dust~~ TODOs. 🚧

Symbol is a work in progress build tool for Standard ML. It's designed to work
alongside and on top of existing SML build tools, like SML/NJ's CM and MLton's
MLBasis files. Symbol's key features are:

- **Designed to build executables**

  Symbol builds and installs runnable executables for your project. With SML/NJ,
  these executables use heap images under the hood, while MLton generates linked
  binaries. These details are internal; the end result is always an executable
  that you can invoke from the command line.

- **Low friction for collaborators**

  Symbol's executable is designed to be checked into your project's version
  control. This means your collaborators do not have to install Symbol globally
  before they can build your project.

- **Built on `make`**

  As much as possible, Symbol uses `make` to cache previous build steps. All
  intermediate outputs are stored into a `.symbol-work` folder in your current
  directory, and it's always safe to delete this folder. Running `symbol make` a
  second time should usually be instant.

- **Scaffold new projects**

  The `symbol new` command is how you initialize new Standard ML projects. It
  prepopulates CM and MLBasis files and copies the Symbol scripts into your
  project, so you can jump write into your project.

- **Convention over configuration**

  Symbol infers information about your project from its structure. This means
  that Symbol does not come with yet another file format to configure your
  project; just keep using `*.cm` files for SML/NJ and `*.mlb` files for MLton.


## Install

TODO(jez) How to install


## Quickstart

TODO(jez) Write a quickstart


## Tips

- Make variables
  - MLTONFLAGS (profiling)
  - target (two executables)
  - main (main function called something else)

- consider adding .symbol-work/bin to your PATH

- Your sources.cm file should not try to hide anything.
  This makes it easier to reuse your sources.cm file for tests.
  If you want to keep things private when writing a library, expose a separate
  CM file for your library users with only the public interface.

## TODO

- TODO(jez) global `symbol` command
  - `new <target>`
    - should initialize the scaffold
    - creates a new folder
  - `setup [<target>]`
    - should just add `symbol` and `.symbol.mk`
    - should error and suggest `symbol upgrade` if these files exist
    - `<target>` defaults to current directory name
  - `upgrade`
    - should just update `symbol` and `.symbol.mk`, not scaffolding
    - have to infer `<target>`
  - `version`
    - should show both project and global version
- TODO(jez) README, website
- TODO(jez) Homebrew formula
- TODO(jez) CLI tests
- TODO(jez) `symbol make | cat` is broken...?

## License

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://jez.io/MIT-LICENSE.txt)

