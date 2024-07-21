(define-library (swankish-server)
  (export define-and-start-repl-server)
  (import (scheme base)
          (scheme read)
          (scheme write)
          (scheme eval)
          (scheme repl)
          (chibi net)
          (chibi net server))

  (begin
    (define-syntax define-and-start-repl-server
      (syntax-rules ()
        ((_ port)
         (begin
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

           (run-net-server port repl-handler)))))))

;; Usage example:
;; (import (swankish-server))
;; (define-and-start-repl-server 5556)
