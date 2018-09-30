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

TODO(jez) These tips are mostly fragments right now

- You're free to structure your project however you want as long as
  - it builds cleanly with just your `*.cm` file and/or `*.mlb` file
    - these files are in the top-level and are named how you want your
      executable named
  - these build files export a `Main.main` function
- in particular, you can pull in dependencies yourself and put them wherever you
  want (so you can use smackage if you want to)

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

- TODO(jez) set up CI
- TODO(jez) Homebrew formula
- TODO(jez) README, website
- TODO(jez) CLI tests
- TODO(jez) Update DECISIONS.md for symbol-new being in shell

## Testing

Implement a test framework, then add tests for:

- test that the scaffold code typechecks
- shellcheck the `symbol` script
- `symbol clean` with no `TARGET.cm` and no `TARGET.mlb`
- two copies of `symbol` and `.symbol.mk` should each be `+1 -1 ~0`
  - the copies in the scaffold should have

## Developer Notes

To bump the version:

- Update the VERSION in `symbol-new`
- Commit the change, and create a new git tag with that version
- Make a new release on GitHub (`hub release`)
- Update the Homebrew formula


## License

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://jez.io/MIT-LICENSE.txt)

