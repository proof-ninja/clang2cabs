# CLANG Parser

## Requirement

* clang plugin by facebook infer

## Comand line interfaces

 `.mas` is a file to which Marshal saves clang abstract syntax trees in
OCaml data.

### `parse`

```console
$ export CLANG_TO_YOJSON=<PATH TO FACEBOOK CLANG PLUGIN>/clang2yojson.sh
$ parse <dir>
```

  parses each `<name>.c` and produces `<name>.mas` in each subdirectory of the directory `<dir>`.

###  `prettyprint`

```console
$ prettyprint <name>.mas
```

  prettyprints abstract syntax trees in <`name>.mas` to the standard output.

### clang2cabs

```console
$ clang2cabs <name>.mas
```

  translates the clang abstract syntax trees in `<name>.mas` into a CABS file `<name>.cabs`

## Installation

The project can be installed with or without opam.

Without opam, you can run the following which relies directly on
dune:

```console
$ git clone git@github.com:proof-ninja/clang2cabs.git
$ cd clang2cabs/
$ make
$ make install
```

With opam, you can install the current development version of your
project as a single opam package. It will override the currently
installed package of the same name, if any:
```
$ opam pin add -k path clang2cabs .
```

For more information on `opam pin`, please consult the
[opam documentation](https://opam.ocaml.org/doc/Usage.html)
