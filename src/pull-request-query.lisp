;;;; bitcoin-core-pr-reviews/src/pull-request-query.lisp

(in-package #:cl-user)
(defpackage #:bitcoin-core-pr-reviews/src/pull-request-query
  (:documentation "Pull request query - GraphQL - GitHub API v4.")
  (:use #:cl)
  (:import-from #:cl-heredoc
                #:read-heredoc)
  (:export #:pull-request-query))
(in-package #:bitcoin-core-pr-reviews/src/pull-request-query)

(eval-when (:compile-toplevel)
  (set-dispatch-macro-character #\# #\> #'read-heredoc))

(defun pull-request-query (pull-request-number)
  (concatenate 'string #>eof>{
    "query": "query {
       rateLimit {
         limit
         cost
         remaining
         resetAt
       }
       repository(owner: bitcoin, name: bitcoin) {
         pullRequest(number: eof pull-request-number #>eof>) {
           number
           publishedAt
           author {
             login
             avatarUrl
           }
           id
           body
           commits(last: 100) {
             totalCount
             edges {
               node {
                 commit {
                   oid
                   url
                   id
                   message
                 }
               }
             }
           }
           comments(last: 100) {
             totalCount
             edges {
               node {
                 publishedAt
                 author {
                   login
                   avatarUrl
                 }
                 url
                 id
                 body
               }
             }
           }
           reviews(last: 100) {
             totalCount
             edges {
               node {
                 publishedAt
                 author {
                   login
                   avatarUrl
                 }
                 url
                 id
                 body
               }
             }
           }
         }
       }
     }"
   }eof))
