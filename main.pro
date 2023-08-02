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
count_films(integer).

clauses 
get_cinema(FName) :- 
film(ID, FName, _, _, _), 
session(ID2, ID, _, _, _), 
cinema(ID2, CName, _, _, ), 
write(CName), nl, fail. 
get_cinema().

get_address_by_genre(Genre) :- 
film(ID, _, _, _, Genre), 
session(ID2, ID, _, _, _), 
cinema(ID2, _, Address, _, ), 
write(Address), nl, fail. 
get_address_by_genre().

get_addresses :- 
findall(Address, 
cinema(_, _, Address, _, _), Addresses), 
write_list(Addresses).

get_address_by_director(Director) :- 
film(ID, _, _, Director, _), 
session(ID2, ID, _, _, _), 
cinema(ID2, _, Address, _, ), 
write(Address), nl, fail. 
get_address_by_director().

count_films(Count) :- 
findall(ID, film(ID, _, _, _, _), IDS), 
length(IDS, Count).

write_list([]) :- !. 
write_list([H|T]) :- 
write(H), nl, write_list(T).

max_grade(Grades, Max) :- 
max_list(Grades, Max).

min_grade(Grades, Min) :- 
min_list(Grades, Min).

average_grade(Grades, Average) :- 
sum_list(Grades, Sum), 
length(Grades, Count), 
Average is Sum / Count.

get_grades_students([], []) :- !. 
get_grades_students([Student|T], [Grades|Grades_T]) :- 
get_grades(Student, Grades), 
get_grades_students(T, Grades_T).

get_grades(Student, Grades) :- 
Grades = Student['exams'].

goal 
consult("cinema.dba", cinema_db), menu.