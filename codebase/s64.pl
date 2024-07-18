#include 'defeasibility.pl'.
#pred c(is_horrorFilm(Film)) :: '@(Film) is a horror film'.
#pred c(is_minor(Person)) :: '@(Person) is a minor'.
#pred c(vPerson1_is_accompanied_by_vPerson2(Person1, Person2)) :: '@(Person1) is accompanied by @(Person2)'. 
#pred c(is_responsiblePerson(Person)) :: '@(Person) is a responsible person'.
#pred c(vPerson1_consents_to_vPerson2_viewing_vFilm(Person1, Person2, Film)) :: '@(Person1) expressly or implicitly consents to @(Person2) viewing @(Film)'.
#pred c(vAge_of_vPerson(Age,Person)) :: '@(Person) is @(Age) years old'.

%% s64(1)
fact(s64_ss1, [Person, to_view(Film), prohibited]) :- c(is_minor(Person)), c(is_horrorFilm(Film)).

%% s64(2)
fact(s64_ss2, [Person1, to_view(Film), permitted]) :- 
	c(is_minor(Person1)), % Person 1 is a minor
	c(is_horrorFilm(Film)), % Film is a horror film
	c(vPerson1_is_accompanied_by_vPerson2(Person1, Person2)), % Person 1 is accompanied by Person 2
	c(is_responsiblePerson(Person2)), % Person 2 is a resposible person
	c(vPerson1_consents_to_vPerson2_viewing_vFilm(Person2, Person1, Film)). % Person 2 consents to Person 1 viewing Film
% In the below line, we use the 'legally_holds(R,C)' function, found in 'defeasibility.pl'. This is defined as true if fact(R,C) is true, and defeated(R,C) is false. You can think of it as equivalent to the c(X) function, but with a specific rule attached to it.
defeated(s64_ss1, [Person, to_view(Film), prohibited]) :- legally_holds(s64_ss2, [Person, to_view(Film), permitted]).


%% s64(3) 
% Note that s64(3) doesn't explicitly assign a prohibition assignment, it just states that s64(2) doesn't apply in the circumstances. Therefore, we only need to include the defeated function, rather than reassigning a prohibition.
fact(s64_ss3, s64_ss2_defeated_withRespectTo_vPerson(Person)) :- c(is_minor(Person)), c(vAge_of_vPerson(Age,Person)), Age < 15.
defeated(s64_ss2, [Person, to_view(Film), permitted]) :- legally_holds(s64_ss3, s64_ss2_defeated_withRespectTo_vPerson(Person)).

%%%% Test Inputs %%%%
/* SCENARIO:
There are two horror movies out, Aliens, and Saw. James is a responsible person and is accompanying Alice and Bob, 15 and 13 years old. James consents to both Alice and Bob watching Aliens, but does not consent to them watching Saw. */

% Establish films:
input(is_horrorFilm(aliens)).
input(is_horrorFilm(saw)).

% Establish entites:
input(is_minor(alice)).
input(is_minor(bob)).
input(is_responsiblePerson(james)).
input(vAge_of_vPerson(15, alice)).
input(vAge_of_vPerson(13, bob)).

% Establish relationships
input(vPerson1_is_accompanied_by_vPerson2(alice, james)).
input(vPerson1_is_accompanied_by_vPerson2(bob, james)).
input(vPerson1_consents_to_vPerson2_viewing_vFilm(james, alice, aliens)).
input(vPerson1_consents_to_vPerson2_viewing_vFilm(james, bob, aliens)).

/* Expected Output:
Neither Alice nor Bob are allowed to watch Saw because they are minors (s64(1)). Alice is allowed to watch Aliens despite being a minor, because she is accompanied by James who consents to her watching it (s64(2) defeats s64(1)). Bob is not allowed to watch Aliens despite the fact that James consents to him watching it, because he is under 15 (s64(3) defeats s64(2)).
*/

