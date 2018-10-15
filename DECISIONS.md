# Symbol Decisions

This file represents a canonical list of decisions that have been made when
implementing Symbol. It's intended as a reference for contributors to understand
the history and context for why certain things are the way they are.


## Decided

- The name "Symbol" was chosen because it sounds like "SML build"
  - Also, it's short, easy to pronounce.
  - Also, `brew search symbol` showed that it wasn't taken as a package name.

- Should be both global and project-local
  - global for `symbol-new` to scaffold new projects
  - project-local so new contributors don't need to install extra tools

- Local `symbol` command written in shell, with a `symbol.mk` file.
  - Shell is more flexible (not everything is a make target)
  - Can print message both before *and* after invoking `make`
  - Easier to control what gets colored
  - Easier to control verbosity (redirect make output to log file)
  - Frees up `Makefile` for the project to use if it wants
  - Can show things for `--help` (instead of `make`'s help)
  - No compilation step needed

- Quiet by default
  - When the tool is working as expected, there should not be much output
  - When something breaks, we should show more things
    - their code didn't compile? SML/NJ / MLton output.
    - something internal broke? debugging output
  - Can always see the debug logs in the `.symbol-work` folder

- No configuration file for first version
  - There are some features that we could implement if we had a config file
    - See Future Directions for more
  - Would either need to be parsed (JSON, TOML) or be sourced (shell, make)
  - Don't *need* these features now, so the first version will nave no
    additional config file.

- `install` command installs to `.local/bin`
  - I copied this behavior from Haskell's `stack`.
  - The GNU conventions for makefiles say that you should default the install
    prefix to `/usr/local`
  - Why did we differ...? `¯\_(ツ)_/¯`
  - Can always pass `prefix=...` to install

- Global `symbol-new` command is written in shell
  - At first I tried implementing this in SML; it would have been nice to
    dogfood the `symbol` build toolchain on the global command
  - It was prohibitively hard to work with the filesystem in SML, so I quit
  - In shell, it was trivial to throw together `cp -r` and `sed`

- Both commands should have solid lint and test coverage.
  - Bash doesn't have any type safety, so we need to make up for it with strong
    linting and testing.
  - Most of our features are file system operations, which can have lots of edge
    cases.

## Future Directions

- Highlight SML/NJ / MLton error output
  - Postprocess `.symbol-work/error.log` with `sed` when printing it to add
    highlighting to the error output.

- Multiple executable targets
  - Would need a CM / MLB file for each target
  - Somewhat blocked on having a configuration file?
    - You can already sort of work around this with `symbol make target=foo`

- `symbol test` command
  - Could be built alongside / on top of the building functionality

- Windows support
  - Most functionality is written in Make / Shell, which is hard on Windows
  - Ideally we support any platform that MLton and SML/NJ support
