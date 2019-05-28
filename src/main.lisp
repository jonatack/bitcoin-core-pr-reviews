;;;; bitcoin-core-pr-reviews/main.lisp

(in-package #:cl-user)
(defpackage #:bitcoin-core-pr-reviews
  (:documentation "A Common Lisp bot that tweets/toots Bitcoin Core PR Reviews")
  (:nicknames #:bitcoin-core-pr-reviews/src/main)
  (:use #:cl #:quri)
  (:shadow #:dexador)
  (:export
   ;; Public API
   ;; Private API
   ))
(in-package #:bitcoin-core-pr-reviews)

(declaim (optimize (speed 0) (safety 3) (debug 3)))
