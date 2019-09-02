;;;; bitcoin-core-pr-reviews/main.lisp

(in-package #:cl-user)

(defpackage #:bitcoin-core-pr-reviews
  (:documentation "A Common Lisp bot that tweets/toots Bitcoin Core PR Reviews")
  (:nicknames #:bitcoin-core-pr-reviews/src/main)
  (:use #:cl)
  (:shadowing-import-from #:dexador
                          #:get
                          #:post)
  (:import-from #:quri
                #:make-uri)
  (:import-from #:jsown
                #:parse)
  (:import-from #:cl-strings
                #:clean)
  (:export #:graphql_post))
(in-package #:bitcoin-core-pr-reviews)

(eval-when (:compile-toplevel)
  (declaim (optimize (speed 2) (safety 3) (debug 3))))

(defparameter *github-host* "api.github.com")
(defparameter *github-path* "/graphql")
(defparameter *github-user* "jonatack")
(defparameter *github-token* "token")

(defun headers ()
  `(("accept" . "application/vnd.github.starfox-preview+json")
    ("user-agent" . ,*github-user*)
    ("authorization" . ,*github-token*)))

(defun stripped (text)
  (clean (remove #\Newline text)))

(defun graphql-post (pull-request-number &key raw verbose)
  (check-type pull-request-number simple-string)
  (let* ((uri (make-uri :scheme "https" :host *github-host* :path *github-path*))
         (data (stripped(pull-request-query pull-request-number)))
         (response (post uri :headers (headers) :content data :verbose verbose)))
    (if raw response (parse response))))
