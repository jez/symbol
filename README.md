# Symbol

[![Build Status](https://travis-ci.org/jez/symbol.svg?branch=master)](https://travis-ci.org/jez/symbol)

> A build tool for Standard ML

Symbol is a build tool for Standard ML. It's designed to work alongside and on
top of existing SML build tools, like SML/NJ's CM and MLton's MLBasis files.

Here's a quick screencast to show off its features:

[![A quick demo of Symbol](https://asciinema.org/a/JjPtmatmrkmPhbkkNF1XHDKM4.svg)](https://asciinema.org/a/JjPtmatmrkmPhbkkNF1XHDKM4)

<!-- TODO(jez) set up https://symbol.sh -->

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

### Builing a Symbol project

```bash
# Build the project (by default uses SML/NJ)
./symbol make

# Build the project with MLton (takes longer, but much faster executable)
./symbol make with=mlton

# Build the project (by default uses MLton), then install to ~/.local/bin
./symbol install

# same as above, but installs to /usr/local/bin
./symbol install prefix=/usr/local
```

### Help

```bash
# Global
symbol-new --help

# Local
./symbol --help
```


## Tips

These are some general tips for working with Symbol and Standard ML.

### Project Structure

Symbol adds an initial project structure with a `src/` folder. Feel free to
arrange the SML source files however you want, and pull in whatever dependencies
you want. **However**:

- There must always be either a `<target>.cm` or `<target>.mlb` in the same
  folder as the `symbol` script.

- The `<target>.cm` must make available a `Main.main` function.
  - This function is given directly to the `ml-build` command.
  - See the [CM User Guide] for more information.

- The choice for `<target>` cannot easily be changed after running `symbol-new`.
  - If you do want to change it, you'll have to manually edit the `target`
    variables in `./symbol` and `./.symbol.mk`

And then a suggestion: keep your `<target>.cm` and `<target>.mlb` files very
transparent. Don't try to hide intermediate signatures, structures, or functors.
This will make it easier to test your code.

If you intend your project to produce **both** an executable and a library, have
a separate CM file that hides internal implementation details from downstream
users of your library, and keep the one that exposes everything.

[CM User Guide]: https://www.smlnj.org/doc/CM/new.pdf

### Your PATH

There are a few folders you might want to add or make sure are in your PATH. To
add all of the below folders to your PATH, add these lines to your bashrc or
zshrc:

```bash
export PATH="$PATH:.symbol-work/bin"
export PATH="$PATH:."
export PATH="$PATH:$HOME/.local/bin"
```

The folders themselves are:

-   `.symbol-work/bin`

    If this folder is in your PATH, you can replace

    ```
    ❯ .symbol-work/bin/my-target
    ```

    with just

    ```
    ❯ my-target
    ```

-   `.` (the current directory)

    If this folder is in your PATH, you can replace

    ```
    ❯ ./symbol make
    ```

    with just

    ```
    ❯ symbol make
    ```

-   `$HOME/.local/bin`

    This is the place where `./symbol install` puts executables by default.
    If this folder is *not* in your PATH, you can use `prefix=...` to specify a
    folder that is on your PATH. For example:

    ```
    ./symbol install prefix=/usr/local
    ```


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

