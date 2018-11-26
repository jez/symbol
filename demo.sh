#!/usr/bin/env bash

# This is the script I used to record the asciicast in the README.
#
# Setup:
#
#     tmux new -s symbol
#
# In another tab:
#
#     ./demo.sh

send() {
  tmux send-keys -t symbol "$@"
}

enter() {
  send Enter
  sleep 0.1
}

delay_enter() {
  sleep 1.5
  enter
}

newline() {
  send Escape "o"
  send "  "
}


mkdir -p ~/demo
rm -rf ~/demo/hello
rm -rf ~/demo/symbol.cast

send "cd ~/demo" && enter

send 'asciinema rec ~/demo/symbol.cast' && enter
sleep 2

send "# Symbol is a lightweight build tool for Standard ML," && newline
send "# designed for building executables."

sleep 4

enter
send "# It's built with existing tools like Make, SML/NJ, and MLton," && newline
send "# which means it works with tools that are already on your system."

sleep 7

enter
send "# It has a handful of convenient features, so let's jump into a demo."

sleep 5

enter
send '# We can use Symbol to scaffold a new project:'
sleep 3.5
enter
send 'symbol-new hello' && delay_enter

sleep 1
send '# ^ our newly created project'
sleep 7

enter
send '# Symbol created a new project in the hello/ folder.' && newline
send "# Inside is a small script named symbol."
sleep 7

enter
send "# Check this script into your repo so collaborators can use Symbol" && newline
send '# without having to install anything on their system.'
sleep 7

enter
send "# Now let's use symbol to build our project:"
sleep 3
enter
send 'cd hello' && delay_enter
send './symbol make' && delay_enter

sleep 1
send "# ^ Symbol successfully built our executable. Let's run it:"
sleep 3

enter
send '.symbol-work/bin/hello' && delay_enter

sleep 1
send '# ^ the scaffold code by default compiles to a "Hello, world!" program.'
sleep 4

enter
send '# Symbol is built on top of Make and CM, so rebuilds are fast and cache results:'
sleep 4
enter
send './symbol make' && delay_enter

sleep 1

send "# Symbol can build your project using either SML/NJ or MLton." && newline
send "# By default, it uses SML/NJ. Let's use MLton this time:"
sleep 8
enter
send './symbol make with=mlton' && delay_enter

sleep 7.5

send "# This took longer because MLton does more optimizations." && newline
send "# But again, the second build is instant:"
sleep 5.5
enter
send './symbol make with=mlton' && delay_enter

sleep 1.5

send "# We can use Symbol to install projects too. This is *really* handy for SML/NJ" && newline
send "# projects, because Symbol manages both the wrapper script and the heap image:"
sleep 11.5
enter
send './symbol install with=smlnj' && delay_enter
sleep 1.5
send 'ls ~/.local/bin/hello ~/.local/lib/hello' && delay_enter

sleep 2
send '# ^ note that our heap image was installed too.'
sleep 4

enter
send "# This covers 90% of Symbol's use cases. Pretty simple, but also low-overhead." && newline
send "# Be sure to read the README and the --help for more information. Thanks!"
sleep 8
enter

send 'exit' && enter
