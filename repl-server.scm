#!/usr/bin/env chibi-scheme

(import (scheme base) (scheme read) (scheme write) (scheme eval) (scheme repl)
        (chibi net) (chibi net server))

(define (geiser?)
  (guard (exn (else #f)) (not (geiser:no-values))))

(define (repl-prompt)
  (display "> ")
  (flush-output-port))

(define (repl-handler in out sock addr)
  (let ((env (interaction-environment)))
    (parameterize ((current-output-port out))
      (repl-prompt)

      (let lp ()
        (let ((expr (read in)))
          (cond
           ((not (eof-object? expr))
            (let ((result (guard (exn (else
                                       (display "ERROR: ")
                                       (write exn)
                                       (newline)
                                       (if #f #f)))
                            (eval expr env))))
              (if (not (geiser?))
                  (cond
                   ((not (eq? result (if #f #f)))
                    (write result out)
                    (newline out))))
              (newline)
              (repl-prompt)
              (flush-output-port)
              (lp)))))))))

(run-net-server 5556 repl-handler)
