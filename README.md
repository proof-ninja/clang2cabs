# CLANG Parser

Parses C source code to create an abstract syntax tree.
The definition of "small C", the language to be parsed, is as follows:

```
#include
#define

P ::= x=e; | if (b) P else P | while (b) P | for (e; e; e) P | return e; | return;
        | { P ... P } | e++; | ++e; | e--; | --e;
e ::= int-constants (..., -1, 0, 1, 2, ...) | variables | a[e]
        for array name a
        | e + e | e - e | e * e | e / e | e % e | (e) | f(e, ..., e)
        for function name f
b ::= e == e | e != e | e < e | e > e | e <= e | e >= e | (e) | !e
        | e && e | e '||' e

type ::= void | bool | integer | float | double
integer ::= [signed | unsigned] (char | short | int | long | long long)
次元配列
関数定義と呼び出し
グローバル変数
ローカル変数 (関数定義のはじめだけ)
```

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


## ocamldoc API

https://proof-ninja.github.io/clang2cabs/
