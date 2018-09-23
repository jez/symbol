structure Main : MAIN =
struct
  fun main (arg0, argv) =
    (print "Hello, world!\n";
     OS.Process.success)
end
