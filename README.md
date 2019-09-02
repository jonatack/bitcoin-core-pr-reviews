# Bitcoin Core PR Reviews

A Common Lisp app to promote Bitcoin Core code review by tweeting PR reviews on
Twitter and tooting them on Mastodon.

## Getting Started

To use, git clone the repo into your `~/quicklisp/local-projects` directory,
then:

```lisp
(ql:quickload 'bitcoin-core-pr-reviews)
(bitcoin-core-pr-reviews::graphql-post "<pull request number" :verbose t)
(bitcoin-core-pr-reviews::graphql-post "<pull request number" :raw t)
```

The API calls accept the following optional boolean keyword parameters:

- RAW (T or default NIL) to return the JSON response as a raw string instead of
  parsed and converted to a list data structure.

- VERBOSE (T or default NIL) to output the HTTP request headers for verifying
  and debugging.

## Dependencies

DEXADOR, QURI, JSOWN, CHIRP, TOOTER, MITO, PostgreSQL.

## Portability

Developed with Steel Bank Common Lisp (SBCL), version 1.5.6.

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
