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
(defparameter *github-queries-path*
  "/home/jon/common-lisp/bitcoin-core-pr-reviews/src/github-graphql-queries/")

(defun db-connect ()
  "Connect to the PostgreSQL database."
  (mito:connect-toplevel
   :postgres
   :database-name "bitcoin_core_pr_reviews"
   :username "jon"
   :password *postgres-password*))

(defun get-pull-request () (github-query "pull_request"))
(defun get-pull-requests () (github-query "pull_requests"))

(defun github-query (filename)
  "Perform a GitHub API query as specified in the given GraphQL file."
  (check-type filename simple-string)
  (graphql-post
   (read-file-into-string
    (concatenate 'string *github-queries-path* filename ".graphql"))))

(defun graphql-post (query &key raw verbose)
  "GraphQL POST request for the GitHub API queries."
  (declare (type simple-string query))
  (let* ((uri (make-uri :scheme "https" :host *github-host* :path *github-path*))
         (data (strip query))
         (response (post uri :headers (headers) :content data :verbose verbose)))
    (if raw response (parse response))))

(defun headers ()
  "HTTP POST headers for the GitHub API GraphQL queries."
  `(("accept" . "application/vnd.github.starfox-preview+json")
    ("user-agent" . ,*github-user*)
    ("authorization" . ,*github-token*)))

(defun strip (string)
  "Remove newline characters, leading/trailing spaces, and multiple spaces."
  (declare (type simple-string string))
  (clean (remove #\Newline string)))

(defun clean (string &key (char #\space))
  "Returns a string with leading/trailing spaces removed and multiple spaces
  replaced by one."
  (declare (type simple-string string)
           (type character char))
  (let ((trimmed (string-trim (string char) string))
        (char-found nil))
    (with-output-to-string (stream)
      (loop for c across trimmed do
               (if (char= c char)
                   (when (not char-found)
                     (write-char c stream)
                     (setq char-found t))
                   (progn
                     (if char-found (setf char-found nil))
                     (write-char c stream)))))))

(defun read-file-into-string (pathname)
  "Return the contents of the file denoted by PATHNAME as a fresh string."
  (declare (type simple-string pathname))
  (with-open-file (stream pathname :direction :input :if-does-not-exist nil)
    (let ((string (make-string (file-length stream))))
      (read-sequence string stream)
      string)))
