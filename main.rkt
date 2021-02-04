#lang racket

(require 2htdp/image
         2htdp/universe)

(module+ main
  (require racket/cmdline)

  (command-line
   #:program "picture-viewer"
   #:args ([dir #f])
   (define image-list
     (map (λ (p)
            (scale 0.4 (bitmap/file p)))
          (find-files
           (λ (p) (path-has-extension? p #".jpg"))
           dir)))
   (define (change w a-key)
     (cond
       [(key=? a-key "left")
        (let ([new-w (sub1 w)])
          (if (negative? new-w)
              0
              new-w))]
       [(key=? a-key "right")
        (let ([new-w (add1 w)])
          (if (>= new-w (length image-list))
              w
              new-w))]
       [else w]))
   (define (drawimage w)
     (list-ref image-list w))
   (big-bang 0
     (to-draw drawimage)
     (on-key change))
   (void)))
