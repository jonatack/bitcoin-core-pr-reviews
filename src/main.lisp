;;;; bitcoin-core-pr-reviews/main.lisp

(in-package #:cl-user)

(defpackage #:bitcoin-core-pr-reviews
  (:documentation "A Common Lisp bot that tweets/toots Bitcoin Core PR Reviews")
  (:nicknames #:bitcoin-core-pr-reviews/src/main)
  (:use #:cl #:mito)
  (:shadowing-import-from #:dexador
                          #:get
                          #:post)
  (:import-from #:quri
                #:make-uri)
  (:import-from #:jsown
                #:parse)
  (:import-from #:cl-strings
                #:clean)
  (:import-from #:bitcoin-core-pr-reviews/src/pull-request-query
                #:pull-request-query)
  (:export #:graphql_post))
(in-package #:bitcoin-core-pr-reviews)

(eval-when (:compile-toplevel)
  (declaim (optimize (speed 2) (safety 3) (debug 3))))

(defparameter *github-host* "api.github.com")
(defparameter *github-path* "/graphql")
(defparameter *github-user* "jonatack")
(defparameter *github-token* "token")
(defparameter *postgres-password* "")

(defun db-connect ()
  (mito:connect-toplevel
   :postgres
   :database-name "bitcoin_core_pr_reviews"
   :username "jon"
   :password *postgres-password*))

(defun graphql-post (query &key raw verbose)
  (check-type query simple-string)
  (let* ((uri (make-uri :scheme "https" :host *github-host* :path *github-path*))
         (data (stripped query))
         (response (post uri :headers (headers) :content data :verbose verbose)))
    (if raw response (parse response))))

(defun headers ()
  `(("accept" . "application/vnd.github.starfox-preview+json")
    ("user-agent" . ,*github-user*)
    ("authorization" . ,*github-token*)))

(defun stripped (string)
  (clean (remove #\Newline string)))

(defun read-file (path)
  (with-open-file (stream path :direction :input :if-does-not-exist nil)
    (let ((string (make-string (file-length stream))))
      (read-sequence string stream)
      string)))
