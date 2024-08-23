(import (scheme base)
        (scheme write))

(define (foo x y) (+ x y))
;; Try C-x C-e on a (foo 3 4) form in geiser

;; Start the swankish server
(import (srfi 18)
        (swankish-server))
(let ((server-thread (make-thread
                      (lambda ()
                        (define-and-start-repl-server 5556)))))
  (thread-start! server-thread)
  (display "Swankish server is running in non-blocking mode.\n")
  (thread-join! server-thread)
  (display "Swankish server exited.\n"))
