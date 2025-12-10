# Używamy lekkiego obrazu Nginx
FROM nginx:alpine

# Kopiujemy naszą stronę HTML do katalogu, z którego Nginx serwuje pliki
COPY index.html /usr/share/nginx/html/

# Eksponujemy port 80 (domyślny dla HTTP)
EXPOSE 80

# CMD jest dziedziczone z obrazu nginx:alpine
# Automatycznie uruchamia nginx
