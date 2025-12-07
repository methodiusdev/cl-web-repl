# cl-web-repl #

## Wstęp

Niniejsze sprawozdanie dokumentuje realizację projektu laboratoryjnego z zakresu
DevOps. Celem zajęć było praktyczne opanowanie narzędzi i technik stosowanych we
współczesnym wytwarzaniu oprogramowania, w tym: konteneryzacji (Docker),
orkiestracji (Kubernetes), kontroli wersji (Git), oraz ciągłej integracji i
wdrażania (CI/CD z GitHub Actions).

Projekt polega na stworzeniu online REPL (Read-Eval-Print Loop) dla języka Common
Lisp. Aplikacja składa się z dwóch kontenerów Docker:

1. Backend - serwer API w Common Lisp (Hunchentoot), który przyjmuje kod Lisp,
ewaluuje go i zwraca wyniki.

2. Frontend - serwer WWW serwujący interfejs użytkownika z polem do wpisywania
kodu.

Komunikacja między kontenerami odbywa się poprzez HTTP REST API. Frontend wysyła
kod do backendu, który go wykonuje i zwraca wynik. Projekt demonstruje klasyczną
architekturę mikroserwisową z podziałem na warstwę prezentacji i logiki
biznesowej.

## Linux

W ramach laboratorium wykonano szereg podstawowych operacji w systemie Linux,
związanych z nawigacją po systemie plików, zarządzaniem plikami i katalogami oraz
instalacją oprogramowania. Poniżej przedstawiono listę wykorzystanych komend wraz
z ich opisem.

| Komenda                    | Opis                                      |
|----------------------------|-------------------------------------------|
| pwd                        | Wyświetla bieżący katalog roboczy         |
| cd ~ lub cd                | Przechodzi do katalogu domowego           |
| cd /etc                    | Przechodzi do katalogu /etc               |
| mkdir ~/Lab1               | Tworzy katalog Lab1 w katalogu domowym    |
| vim notatki.txt            | Otwiera edytor vim do edycji pliku        |
| cat notatki.txt            | Wyświetla zawartość pliku                 |
| ls -l notatki.txt          | Wyświetla szczegóły pliku z uprawnieniami |
| chmod 666 notatki.txt      | Zmienia uprawnienia na rw-rw-rw-          |
| ls /etc > lista_plikow.txt | Przekierowuje wynik ls do pliku           |
| find /etc -name "*.conf"   | Znajduje pliki .conf w /etc               |
| sudo apt update            | Aktualizuje listę pakietów                |
| sudo apt install htop -y   | Instaluje program htop                    |
| htop                       | Uruchamia interaktywny monitor procesów   |

## Git

