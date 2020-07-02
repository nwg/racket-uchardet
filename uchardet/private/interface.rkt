#lang racket/base


(require (prefix-in ucd: "bindings.rkt"))
(provide uchardet-get-charset)

(define CHUNK_SIZE 4096)

(define (detect-encoding #:in [in (current-input-port)])
  (let ([bytes (make-bytes CHUNK_SIZE)]
        [ucd (ucd:new)])
    (define (loop)
      (let ([result (read-bytes! bytes in)])
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
    (loop)))
  
  
	
(define (uchardet-get-charset filename)
  (let ([result (with-input-from-file filename detect-encoding #:mode 'binary)])
    (case result
      [("") #f]
      [else result])))
