#lang racket/base

(module+ test
  (require rackunit))

;; Notice
;; To install (from within the package directory):
;;   $ raco pkg install
;; To install (once uploaded to pkgs.racket-lang.org):
;;   $ raco pkg install <<name>>
;; To uninstall:
;;   $ raco pkg remove <<name>>
;; To view documentation:
;;   $ raco docs <<name>>
;;
;; For your convenience, we have included LICENSE-MIT and LICENSE-APACHE files.
;; If you would prefer to use a different license, replace those files with the
;; desired license.
;;
;; Some users like to add a `private/` directory, place auxiliary files there,
;; and require them in `main.rkt`.
;;
;; See the current version of the racket style guide here:
;; http://docs.racket-lang.org/style/index.html

;; Code here

(require (prefix-in ucd: "interface.rkt"))
(provide (all-from-out "interface.rkt"))

(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.

    (define (get-charset filename)
        (let ([bytes (make-bytes 4096)]
              [ucd (ucd:new)])
          (with-input-from-file
            data-file
            (λ ()
               (define (loop)
                 (let ([result (read-bytes! bytes)])
                   (if (eof-object? result)
                       (begin
                           (ucd:data-end ucd)
                           (ucd:get-charset ucd))
                       (begin
                         (ucd:handle-data ucd bytes result)
                         (let ([charset (ucd:get-charset ucd)])
                           (if (not (equal? charset ""))
                               charset
                               (loop)))))))
               (loop))
            #:mode 'binary)))

    (require racket/runtime-path)

    (define-runtime-path data-file "test-data/sample.WINDOWS-1252")
    (check-equal? (get-charset data-file) "WINDOWS-1252"))

(module+ main
  ;; (Optional) main submodule. Put code here if you need it to be executed when
  ;; this file is run using DrRacket or the `racket` executable.  The code here
  ;; does not run when this file is required by another module. Documentation:
  ;; http://docs.racket-lang.org/guide/Module_Syntax.html#%28part._main-and-test%29

  (require racket/cmdline)
  (define who (box "world"))
  (command-line
    #:program "my-program"
    #:once-each
    [("-n" "--name") name "Who to say hello to" (set-box! who name)]
    #:args ()
    (printf "hello ~a~n" (unbox who))))
