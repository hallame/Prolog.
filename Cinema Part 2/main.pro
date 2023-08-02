domains
  cinema_name = string
  address = string
  phone = string
  film_name = string
  director = string
  genre = string
  date = string
  time = string
  intlist = integer*

database - cinema_db
  cinema(integer, cinema_name, address, phone, integer)
  film(integer, film_name, integer, director, genre)
  session(integer, integer, date, time, integer)
  
predicates
  get_cinema(film_name).
  get_address_by_genre(genre).
  get_addresses.
  get_address_by_director(director).
  length(intlist, integer).
  count_films(integer).
  
  nondeterm menu.
  nondeterm menu_item(integer).
  
clauses
  get_cinema(FName) :-
    film(ID, FName, _, _, _),
    session(ID2, ID, _, _, _),
    cinema(ID2, CName, _, _, _),
    write(CName), nl, fail.
  get_cinema(_).
    
  get_address_by_genre(Genre) :-
    film(ID, _, _, _, Genre),
    session(ID2, ID, _, _, _),
    cinema(ID2, _, Address, _, _),
    write(Address), nl, fail.
  get_address_by_genre(_).
    
  get_addresses :-
    cinema(_, _, Address, _, _),
    write(Address), nl, fail.
  get_addresses.
  
  get_address_by_director(Director) :-
    film(ID, _, _, Director, _),
    session(ID2, ID, _, _, _),
    cinema(ID2, _, Address, _, _),
    write(Address), nl, fail.
  get_address_by_director(_).
    
  length([], 0).
  length([_|T], L) :-
    length(T, L2),
    L = L2 + 1.
    
  count_films(Count) :-
    findall(ID, film(ID, _, _, _, _), IDS),
    length(IDS, Count).
    
  menu :-
     write("Введите номер задачи: "),
     readint(H),
     menu_item(H).
     
   menu_item(0) :- !.
   menu_item(1) :-
     write("Введите название фильма: "),
     readln(Film),
     get_cinema(Film), nl.
   menu_item(2) :-
     write("Введите название жанра: "),
     readln(Genre),
     get_address_by_genre(Genre), nl.
   menu_item(3) :-
     get_addresses, nl.
   menu_item(4) :-
     write("Введите имя режиссера: "),
     readln(Director),
     get_address_by_director(Director), nl.
   menu_item(5) :-
     count_films(Count), write("Количество фильмов: "), write(Count), nl.  
   
goal
  consult("cinema.dba", cinema_db),
  menu.
