;;;; bitcoin-core-pr-reviews/tests/main.lisp

(defpackage #:bitcoin-core-pr-reviews/tests/main
  (:use #:cl #:rove))
(in-package #:bitcoin-core-pr-reviews/tests/main)

(deftest example
    (ok (= 1 1)))
