# chibi-repl-server

A repl server for chibi scheme


## Repl-server Usage

Install `geiser` and `geiser-chibi`, and then start the repl server, ensuring
that the geiser chibi scheme module is loaded into the environment:

```
$ chibi-scheme -I/home/risto/.emacs.d/elpa/geiser-chibi-20240521.2252/src/geiser/
-m geiser repl-server.scm
```

Then start geiser with `geiser-connect` with `localhost` and the port in the
script file, or change these values if you're doing SSH tunneling.


## Swank-server usage

TODO
