# Symbol

[![Build Status](https://travis-ci.org/jez/symbol.svg?branch=master)](https://travis-ci.org/jez/symbol)

> A build tool for Standard ML

🚧 This project is unfinished and ongoing. Pardon our ~~dust~~ TODOs. 🚧

Symbol is a work in progress build tool for Standard ML. It's designed to work
alongside and on top of existing SML build tools, like SML/NJ's CM and MLton's
MLBasis files.

TODO(jez) Screencast

- - -

Symbol's key features are:

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

  As much as possible, Symbol uses `make` to cache previous build steps. Running
  `symbol make` a second time should usually be instant. All intermediate
  outputs are stored into a `.symbol-work` folder in your current directory, and
  it's always safe to delete this folder.

- **Scaffold new projects**

  The `symbol new` command is how you initialize new Standard ML projects. It
  prepopulates CM and MLBasis files and copies the Symbol scripts into your
  project, so you can jump write into your project.

- **Convention over configuration**

  Symbol infers information about your project from its structure. This means
  that Symbol does not come with yet another file format to configure your
  project; just keep using `*.cm` files for SML/NJ and `*.mlb` files for MLton.

## Install

Installing Symbol globally is **only required** by the collaborators who
initially set up new SML projects. The global command is called `symbol-new` and
is used solely for scaffolding new projects. Once a Symbol project has been
created, a script called `symbol` will exist locally within that project.

### macOS

On macOS, you can use Homebrew:

```bash
brew install jez/formulae/symbol-new
```

### From source

You can also install from source:

```bash
git clone https://github.com/jez/symbol
cd symbol
make install
```

This will install to `~/.local/bin/symbol-new`. If you'd like to install to
a different prefix, you can pass that to the `make` command. For example,

```bash
make install prefix=/usr/local
```

will instead install to `/usr/local/bin/symbol-new`.


## Quickstart

### Creating a new project

```bash
symbol-new <target>
# where `<target>` is the name to call the executable for your project.
```

### Working with an existing project

```bash
# Build the project (by default uses SML/NJ)
symbol make

# Build the project with MLton (takes longer, but much faster executable)
symbol make with=mlton

# Build the project (by default uses MLton), then install to ~/.local/bin
symbol install

# same as above, but installs to /usr/local/bin
symbol install prefix=/usr/local
```

### Help

```bash
# Global
symbol-new --help

# Local
symbol --help
```


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

TODO(jez) set up https://symbol.sh


## Contributing

To learn about historical context and implementation decisions:

- Read [DECISIONS.md](DECISIONS.md)

To set up your development environment:
```bash
# macOS:
brew bundle

# linux: install the packages listed in ./Brewfile
```

For developing on Symbol locally:

```bash
# To run the lint checks:
make lint

# To run the tests:
make test

# To re-record the snapshot tests:
make test update=1
```

To make a new test:

- Add a `.sh` file anywhere in `tests/`.
- Make it executable.

To make a new snapshot test:

- Make a new test, say `tests/foo.sh`
- Make an empty file like `tests/foo.sh.exp`
- Run `make test update=1`

To bump the version:

- Update the VERSION in `symbol-new`
- Commit the change, and create a new git tag with that version
- Make a new release on GitHub (`hub release`)
- Update the Homebrew formula


## License

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://jez.io/MIT-LICENSE.txt)

