#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define
         racket/bool
         ffi/unsafe/alloc)

(provide new delete handle-data data-end reset get-charset)

(define-ffi-definer define-uchardet (ffi-lib "libuchardet"))

(define (check f)
 (λ (v who)
     (unless (f v)
       (error who "failed: ~a" v))))

(define check-zero? (check zero?))

(define uchardet_t-pointer (_cpointer 'uchardet_t))

(define-uchardet
  delete
  (_fun uchardet_t-pointer -> _void)
  #:c-id uchardet_delete
  #:wrap (deallocator))

(define-uchardet
  new
  (_fun -> uchardet_t-pointer)
  #:c-id uchardet_new
  #:wrap (allocator delete))

(define-uchardet handle-data
                 (_fun uchardet_t-pointer _bytes _int -> (r : _int)
                  -> (check-zero? r 'handle_data))
                 #:c-id uchardet_handle_data)

(define-uchardet data-end
                 (_fun uchardet_t-pointer -> _void)
                 #:c-id uchardet_data_end)

(define-uchardet reset
                 (_fun uchardet_t-pointer -> _void)
                 #:c-id uchardet_reset)

(define-uchardet get-charset
                 (_fun uchardet_t-pointer -> _string)
                 #:c-id uchardet_get_charset)

