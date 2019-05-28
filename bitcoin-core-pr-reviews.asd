;;;; bitcoin-core-pr-reviews.asd

(defsystem "bitcoin-core-pr-reviews"
  :name "Bitcoin Core PR Reviews"
  :author "Jon Atack <jon@atack.com>"
  :description "A Common Lisp library that tweets/toots Bitcoin Core PR Reviews"
  :homepage "https://github.com/jonatack/bitcoin-core-pr-reviews"
  :license "MIT"
  :version "0.0.1"
  :class :package-inferred-system
  :depends-on ("bitcoin-core-pr-reviews/src/main")
  :in-order-to ((test-op (test-op "bitcoin-core-pr-reviews/tests"))))

(defsystem "bitcoin-core-pr-reviews/tests"
  :name "Bitcoin Core PR Reviews tests"
  :author "Jon Atack <jon@atack.com>"
  :description "Unit tests for Bitcoin Core PR Reviews"
  :class :package-inferred-system
  :depends-on ("rove"
               "bitcoin-core-pr-reviews/tests/main")
  :perform (test-op (op c) (symbol-call :rove '#:run c)))
