val (arg0, argv) = (CommandLine.name (), CommandLine.arguments ())
val _ = OS.Process.exit (Main.main (arg0, argv))
