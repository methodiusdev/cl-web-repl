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

Link do repozytorium z kodem:
[methodiusdev/cl-web-repl](https://github.com/methodiusdev/cl-web-repl)
;
### Wykorzystane komendy Git

| Komenda                                      | Opis                                                 |
|----------------------------------------------|------------------------------------------------------|
| ssh-keygen -t ed25519 -C "email@example.com" | Generuje parę kluczy SSH (publiczny i prywatny)      |
| cat ~/.ssh/id_ed25519.pub                    | Wyświetla klucz publiczny SSH                        |
| ssh -T git@github.com                        | Testuje połączenie SSH z GitHubem                    |
| git clone git@github.com:user/repo.git       | Klonuje repozytorium z GitHuba                       |
| git config --global user.name "Name"         | Ustawia nazwę użytkownika Git globalnie              |
| git config --global user.email "email"       | Ustawia email użytkownika Git globalnie              |
| git checkout -b feature/branch-name          | Tworzy nowy branch i przełącza się na niego          |
| git branch                                   | Wyświetla listę branchy i zaznacza aktualny          |
| git add .                                    | Dodaje wszystkie zmiany do staging area              |
| git status                                   | Pokazuje status plików (zmodyfikowane, dodane, itp.) |
| git commit -m "message"                      | Tworzy commit ze zmianami i opisem                   |
| git push -u origin branch-name               | Wysyła branch na GitHub i ustawia tracking           |

### Procedura wygenerowania klucza SSH i dodania go do GitHub

Klucz SSH wygenerowano przy użyciu komendy `ssh-keygen -t ed25519 -C "email
example.com"`, gdzie parametr `-t ed25519` określa typ klucza wykorzystującego
nowoczesny algorytm Ed25519, a `-C` dodaje komentarz ułatwiający identyfikację.
Podczas generowania system pyta o lokalizację zapisu klucza (zatwierdzono
domyślną `~/.ssh/id_ed25519`) oraz opcjonalne hasło zabezpieczające klucz
prywatny. W rezultacie powstają dwa pliki: klucz prywatny `id_ed25519`, który
należy chronić i nigdy nie udostępniać, oraz klucz publiczny `id_ed25519.pub`,
który można bezpiecznie przekazać innym systemom

Zawartość klucza publicznego wyświetlono komendą `cat ~/.ssh/id_ed25519.pub` i
skopiowano w całości. Na platformie GitHub należy przejść do sekcji Settings →
SSH and GPG keys, kliknąć "New SSH key", wkleić skopiowany klucz publiczny,
nadać mu nazwę identyfikującą urządzenie i potwierdzić dodanie. Poprawność
konfiguracji można zweryfikować komendą `ssh -T git@github.com`, która zwraca
komunikat potwierdzający pomyślne uwierzytelnienie

### Po co wykorzystujemy klucze SSH?

Klucze SSH służą do bezpiecznego uwierzytelniania w systemach wykorzystujących
protokół SSH, w tym na platformie GitHub. Główną zaletą kluczy SSH jest
wykorzystanie kryptografii asymetrycznej, gdzie klucz prywatny nigdy nie
opuszcza komputera użytkownika, a klucz publiczny dodany do GitHub może jedynie
weryfikować tożsamość bez możliwości uzyskania dostępu. Dzięki temu
uwierzytelnianie jest bezpieczniejsze niż w przypadku hasła, które musi być
przesyłane przez sieć

Klucze te eliminują także konieczność wprowadzania hasła przy każdej operacji,
co znacząco zwiększa wygodę pracy. Jest to również kluczowe dla automatyzacji
procesów w CI/CD, gdzie systemy muszą uwierzytelniać się bez interakcji
użytkownika. Dodatkowo klucze SSH ułatwiają zarządzanie dostępem, ponieważ
można posiadać wiele kluczy dla różnych urządzeń i łatwo je usuwać bez
konieczności zmiany hasła do całego konta

Mechanizm działania opiera się na zasadzie challenge-response: gdy użytkownik
próbuje się połączyć, GitHub wysyła losowe wyzwanie, które lokalna maszyna
podpisuje swoim kluczem prywatnym. GitHub następnie weryfikuje podpis używając
przechowywanego klucza publicznego. Jeśli weryfikacja się powiedzie,
uwierzytelnienie jest udane, a sam klucz prywatny nigdy nie jest przesyłany
przez sieć, co znacząco zwiększa bezpieczeństwo połączenia.
