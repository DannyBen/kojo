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
| [03-config](03-config) | Showing the use of the `kojo config` command to generate several output files from the same source template.
| [04-not-only-yaml](04-not-only-yaml) | Showing how kojo is used on other types of files.
| [05-folder-nesting](05-folder-nesting) | Showing how `@import` can be used to reference files in other folders.
| [06-save-to-file](06-save-to-file) | Showing how to save output to a file.
| [07-save-to-folder-config](07-save-to-folder-config) | Showing how to generate multiple files from a single source template using `kojo config`.
| [08-cascading-variables](08-cascading-variables) | Showing how variables are forwarded from top to bottom.
| [09-dir](09-dir) | Showing how to compile a directory of templates and create a similar output directory using `kojo dir`.
| [10-dir-save](10-dir-save) | Same as the `09-dir` example, but saving the output to a new directory.
| [11-argfile-file](11-argfile-file) | Showing how to provide arguments from a file to `kojo file`.
| [12-argfile-config](12-argfile-config) | Showing how to provide arguments from a file to `kojo config`.
| [13-argfile-dir](13-argfile-dir) | Showing how to provide arguments from a file to `kojo dir`.
| [14-erb](14-erb) | Showing how to use ERB for conditional output.
