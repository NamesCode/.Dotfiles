{pkgs, ...}: {
  home.packages = [pkgs.gdb];
  home.file.".gdbinit".text = ''
    # adapted from https://gist.github.com/CocoaBeans/1879270

    # set to 1 to enable 64bits target by default (32bit is the default)
    set $64BITS = 1

    set confirm off
    set verbose off
    set prompt \033[31mgdb$ \033[0m

    # disable pagination
    set pagination off

    # display instructions in Intel format
    set disassembly-flavor intel

    # show more by default
    set $SHOW_CONTEXT = 1
    set $SHOW_NEST_INSN = 0

    set $CONTEXTSIZE_STACK = 6
    set $CONTEXTSIZE_DATA  = 8
    set $CONTEXTSIZE_CODE  = 8

    # set to 0 to remove display of objectivec messages (default is 1)
    set $SHOWOBJECTIVEC = 1
    # set to 0 to remove display of cpu registers (default is 1)
    set $SHOWCPUREGISTERS = 1
    # set to 1 to enable display of stack (default is 0)
    set $SHOWSTACK = 0
    # set to 1 to enable display of data window (default is 0)
    set $SHOWDATAWIN = 0
  '';
}
