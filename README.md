# Bitcoin Core PR Reviews

A Common Lisp bot to promote reviewing Bitcoin Core PRs by tweeting them on Twitter and tooting them on Mastodon.


## Dependencies

DEXADOR, QURI, JSOWN, CHIRP, TOOTER, MITO, PostgreSQL.


## Portability

Developed with Steel Bank Common Lisp (SBCL), version 1.5.3.


## Tests

To run the test suite, the ROVE test library needs to be loaded.

```lisp
(ql:quickload :rove)
```

Then run the tests using one of the following:

```lisp
(asdf:test-system :bitcoin-core-pr-reviews)            ; Detailed test output.
(rove:run :bitcoin-core-pr-reviews/tests :style :spec) ; Detailed test output.
(rove:run :bitcoin-core-pr-reviews/tests :style :dot)  ; One dot per test output (in Rove master).
(rove:run :bitcoin-core-pr-reviews/tests :style :none) ; Minimal test output.
```

To run the tests of one test file only, append the file name without the extension:

```lisp
(rove:run :bitcoin-core-pr-reviews/tests/main)         ; Run tests in tests/main.lisp only.
```


### Author

* Jon Atack (jon@atack.com)


### Copyright

Copyright (c) 2019 Jon Atack (jon@atack.com)
