Examples
==================================================

Each example folder contains:

1. Minimalistic sample configuration files.
2. A simple `runme` executable script, showing the command line required to
   run the example.
3. Expected output (stdout) in `output.txt`, and in case the command generates
   a file or a folder, it will be placed in `result`.

To run the examples:

```shell
$ cd examples/<selected example>
$ ./runme
```

Index
--------------------------------------------------

1. [Variables](variables)  
   Showing the use of `%{variables}`.
2. [Variables in Filenames](variables-in-filenames)  
   Showing the use of `%{variables}` in filenames.
3. [Import](import)  
   Showing the use of `@import`.
4. [One to Many - Config from File](config-from-file)  
   Showing the use of the `kojo config` command to generate several output files from the same source template.
5. [Many to Many - Config from Directory](config-from-dir)  
   Showing the use of the `kojo config` command to generate several output directories from the same source directory.
6. [Other File Types](not-only-yaml)  
   Showing how kojo is used on other types of files.
7. [Nested Import Commands](folder-nesting)  
   Showing how `@import` can be used to reference files in other folders.
8. [Save to File](save-to-file)  
   Showing how to save output to a file.
9. [One to Many](save-to-folder-config)  
   Showing how to generate multiple files from a single source template using `kojo config`.
10. [Cascading Variables](cascading-variables)  
    Showing how variables are forwarded from top to bottom.
11. [Compile Directory](dir)  
    Showing how to compile a directory of templates and create a similar output directory using `kojo dir`.
12. [Compile Directory and Save](dir-save)  
    Same as the `Compile Directory` example, but saving the output to a new directory.
13. [Arguments from File - file command](argfile-file)  
    Showing how to provide arguments from a file to `kojo file`.
14. [Arguments from File - config command](argfile-config)  
    Showing how to provide arguments from a file to `kojo config`.
15. [Arguments from File - dir command](argfile-dir)  
    Showing how to provide arguments from a file to `kojo dir`.
16. [ERB](erb)  
    Showing how to use ERB for conditional output.
17. [Interactive Form Templates](form)  
    Showing how to use ERB/ERBX templates with built in interactivity prompt.