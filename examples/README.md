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

| Example | Description 
| --------|-----------------------------------------
| [01-variables](01-variables) | Showing the use of `%{variables}`.
| [02-import](02-import) | Showing the use of `@import`.
| [03-config-from-file](03-config-from-file) | Showing the use of the `kojo config` command to generate several output files from the same source template.
| [04-config-from-dir](04-config-from-dir) | Showing the use of the `kojo config` command to generate several output directories from the same source directory.
| [05-not-only-yaml](05-not-only-yaml) | Showing how kojo is used on other types of files.
| [06-folder-nesting](06-folder-nesting) | Showing how `@import` can be used to reference files in other folders.
| [07-save-to-file](07-save-to-file) | Showing how to save output to a file.
| [08-save-to-folder-config](08-save-to-folder-config) | Showing how to generate multiple files from a single source template using `kojo config`.
| [09-cascading-variables](09-cascading-variables) | Showing how variables are forwarded from top to bottom.
| [10-dir](10-dir) | Showing how to compile a directory of templates and create a similar output directory using `kojo dir`.
| [11-dir-save](11-dir-save) | Same as the `09-dir` example, but saving the output to a new directory.
| [12-argfile-file](12-argfile-file) | Showing how to provide arguments from a file to `kojo file`.
| [13-argfile-config](13-argfile-config) | Showing how to provide arguments from a file to `kojo config`.
| [14-argfile-dir](14-argfile-dir) | Showing how to provide arguments from a file to `kojo dir`.
| [15-erb](15-erb) | Showing how to use ERB for conditional output.
