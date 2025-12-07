;;;; Simple Common Lisp web REPL

(ql:quickload '(:hunchentoot :cl-json))

(defpackage :lisp-repl-backend
  (:use :cl :hunchentoot))

(in-package :lisp-repl-backend)

;; Enable CORS for local development
(defun add-cors-headers ()
  (setf (header-out "Access-Control-Allow-Origin") "*")
  (setf (header-out "Access-Control-Allow-Methods") "POST, GET, OPTIONS")
  (setf (header-out "Access-Control-Allow-Headers") "Content-Type"))

;; Main eval endpoint
(define-easy-handler (eval-endpoint :uri "/eval") (code)
  (add-cors-headers)
  (setf (content-type*) "application/json")
  
  (handler-case
      (let* ((result (eval (read-from-string code)))
             (result-str (format nil "~A" result)))
        (cl-json:encode-json-to-string
         `((:status . "success")
           (:result . ,result-str))))
    (error (e)
      (cl-json:encode-json-to-string
       `((:status . "error")
         (:message . ,(format nil "~A" e)))))))

;; Health check endpoint
(define-easy-handler (health :uri "/health") ()
  (setf (content-type*) "application/json")
  (cl-json:encode-json-to-string
   `((:status . "ok")
     (:message . "Common Lisp REPL Backend is running"))))

;; Start server
(defun start-server (&key (port 8080))
  (format t "Starting Lisp REPL Backend on port ~A~%" port)
  (start (make-instance 'easy-acceptor :port port)))

;; For Docker - start and keep running
(start-server :port 8080)
(loop (sleep 1))

