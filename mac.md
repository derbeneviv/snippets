# map keys windows-like

1) use karabiner to make complex modifications (like swap cmd+space -> alt-shift)

2) create `~/Library/KeyBindings/DefaultKeyBinding.Dict` to map various keybinds (most needed is ctrl\shift + insert and home\end). 
   Reference: https://gist.github.com/trusktr/1e5e516df4e8032cbc3d#file-defaultkeybinding-dict  
```
{
"\UF729"   = "moveToBeginningOfLine:";                       /* Home         */
"@\UF729"  = "moveToBeginningOfDocument:";                   /* Cmd  + Home  */
"$\UF729"  = "moveToBeginningOfLineAndModifySelection:";     /* Shift + Home */
"@$\UF729" = "moveToBeginningOfDocumentAndModifySelection:"; /* Shift + Cmd  + Home */
"\UF72B"   = "moveToEndOfLine:";                             /* End          */
"@\UF72B"  = "moveToEndOfDocument:";                         /* Cmd  + End   */
"$\UF72B"  = "moveToEndOfLineAndModifySelection:";           /* Shift + End  */
"@$\UF72B" = "moveToEndOfDocumentAndModifySelection:";       /* Shift + Cmd  + End */
"\UF72C"   = "pageUp:";                                      /* PageUp       */
"\UF72D"   = "pageDown:";                                    /* PageDown     */
"$\UF728"  = "cut:";                                         /* Shift + Del  */
"$\UF727"  = "paste:";                                       /* Shift + Ins */
"^\UF727"  = "copy:";                                        /* Cmd  + Ins  */
"$\UF746"  = "paste:";                                       /* Shift + Help */
"@\UF746"  = "copy:";                                        /* Cmd  + Help (Ins) */
"@\UF702"  = "moveWordBackward:";                            /* Cmd  + LeftArrow */
"@\UF703"  = "moveWordForward:";                             /* Cmd  + RightArrow */
"@$\UF702" = "moveWordBackwardAndModifySelection:";   /* Shift + Cmd  + Leftarrow */
"@$\UF703" = "moveWordForwardAndModifySelection:";   /* Shift + Cmd  + Rightarrow */
}
```
