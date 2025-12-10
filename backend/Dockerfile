# Używamy oficjalnego obrazu SBCL (Steel Bank Common Lisp)
FROM clfoundation/sbcl:latest

# Ustawiamy katalog roboczy w kontenerze
WORKDIR /app

# Pobieramy i instalujemy Quicklisp
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp && \
    sbcl --non-interactive \
         --load quicklisp.lisp \
         --eval '(quicklisp-quickstart:install :path "/root/quicklisp/")' \
         --quit && \
    echo '(load "/root/quicklisp/setup.lisp")' > /root/.sbclrc && \
    rm quicklisp.lisp

# Pre-instalujemy biblioteki używając .sbclrc
RUN sbcl --non-interactive \
         --eval '(quicklisp:quickload :hunchentoot)' \
         --eval '(quicklisp:quickload :cl-json)' \
         --quit

# Kopiujemy kod serwera do kontenera
COPY server.lisp /app/

# Eksponujemy port 8080
EXPOSE 8080

# Uruchamiamy serwer
CMD ["sbcl", "--load", "server.lisp"]
