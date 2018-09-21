structure Main : MAIN =
struct
  fun main (arg0, argv) =
    (print "Hello, world!";
     OS.Process.success)
end
