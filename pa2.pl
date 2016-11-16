% COMP3071 - PA2

when(1000,10).
when(1200,12).
when(3400,11).
when(3350,12).
when(2350,11).
where(1000,dobbs102).
where(1200,dobbs118).
where(3400,wentw216).
where(3350,wentw118).
where(2350,wentw216).
enroll(mary,1200).
enroll(john,3400).
enroll(mary,3350).
enroll(john,1000).
enroll(jim,1000).

/************************************
*****                           *****
***** In your final submission, *****
***** leave the text above this *****
*****    comment untouched.     *****
*****                           *****
************************************/

/*************************************
** define your four predicates here **
*************************************/

/*
* schedule/3	
* The schedule predicate should take the parameters of (student, classroom, time). 
* With this predicate, we can form queries such as ?- schedule(mary, P, T). and get results: P = dobbs118 T = 12; P = wentw118 T = 12; 
* This predicate can also query a classroom’s usage with something like ?- schedule(S, wentw216, T).
* This will show all the students in a classroom and the times that they are there.
*/
schedule(S, P, T) :- when_(X, T), where(X, P), enroll(S, X).

/*
* usage/2	
* The usage predicate gives all the times that a classroom is in use.
* For example, ?- usage(dobbs102, T). would result in: T = 10; 
* The query usage(X, 12). should return all of the classrooms that are in use at 12.
*/
usage(P, T) :- where(X, P), when_(X, T).

/*
* conflict/2
* A conflict exists if two courses are using the same classroom at the same time. 
* ?- conflict(X, 3350). should return false.
* The query conflict(X,Y). should return all room conflicts in the database. 
* The two arguments are course numbers.  
*/
conflict(X, Y) :- where(X, P), where(Y, P), when_(X, T), when_(Y, T), X \== Y.

/*
* meet/2
* This predicate will decide if two students can meet each other, according to their schedules. 
* There are two ways that two students can meet: 
* 	either they can meet by being enrolled in the same course, 
* 	or they can have different classes in the same classrooms at adjacent times (off by an hour). 
* (For this predicate, you only need to return true for one ordering of the query. For example, meet(mary, john). might be true, or meet(john, mary). might be true.
*/
meet(X, Y) :- enroll(X, Z), enroll(Y, Z), X \== Y.
meet(X, Y) :- enroll(X, A), when_(A, T), enroll(Y, B), addsub(T, I, J), (when_(B, I); when_(B, J)), where(A, P), where(B, P), X \== Y.
addsub(X, Y, Z) :- Y is X+1, Z is X-1.


