(import (scheme base)
        (scheme write))
(import (swankish-server))

(define (foo x y) (+ x y))
;; Try C-x C-e on a (foo 3 4) form in geiser

(define-and-start-repl-server 5556)

