signature MAIN =
sig
  (*
   * The name of your project's main function. It should have type:
   *
   *    string * string list -> OS.Process.status
   *    │        │              │
   *    └─ arg0  └─ arg1 ...    └─ exit code
   *
   * When using SML/NJ, we will use SMLofNJ.exportFn to create a heap image
   * which immediately calls this function. (See the SMLofNJ.exportFn docs for
   * more information.)
   *
   * When using MLton, the generated binary will immediately call this function.
   * (See the file 'call-main.sml')
   *)
  val main : string * string list -> OS.Process.status
end
