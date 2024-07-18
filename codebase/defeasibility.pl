% We bundle ([E,A,M]) all together because they don't make sense without one-another.

#pred assignment(R, [E,A,M]) :: 'According to rule @(R), the entity @(E) is assigned the modality @(M) with respect to the action @(A)'.

#pred according_to(R,C) :: 'According to @(R), the conclusion @(C) holds'.

%according_to(R,C) :- 
%	assignment(R,[E,A,M]),
%	C = [E,A,M].

%according_to(R,C) :- 
%	fact(R,C).




% a conclusion holds if it is found and not defeated.
#pred legally_holds(R,C) :: 'The conclusion @(C) from rule @(R) ultimately holds'.
legally_holds(R,C) :-
	fact(R,C),
   	not defeated(R,C).

legally_holds(R,C) :-
	assignment(R,[E,A,M]),
	C = [E,A,M],
	not defeated(R,C).

%#pred conclusion() :: '@(C) is a conclusion'.
%conclusion(E,A,M) :-
%    legally_holds(R,[E,A,M]).
%conclusion(C) :-
%    legally_holds(R,C).

%% c(C) = Absolute Fact -- either input by user or deduced to legally hold.
#pred c([E,A,M]) :: '@(Entity) is assigned the modality, @(Modality), with respect to the action, @(Action)'.
%#pred c(C) :: '@(C) is true'.
c(C) :- legally_holds(R,C).

#pred input(C) :: '@(C) was provided as input'.
c(C) :- input(C).

#pred list_all(X) :: '@(X) is a conclusion'.
list_all(X) :- c(X).


member(X, [X|Xs]).  
member(X, [_|Xs]):- member(X, Xs).


%#prec c([Entity, Action, Modality]) :: '@(Entity) is assigned the modality, @(Modality), with respect to the action, @(Action)'.




