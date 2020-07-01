#lang info
(define collection "uchardet")
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/uchardet.scrbl" ())))
(define pkg-desc "uchardet wrapper package")
(define version "0.0.1")
(define pkg-authors '(nwg))
(define copy-foreign-libs '("lib/libuchardet.dylib"))
