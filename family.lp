% family.lp
% Project 2 – Logic Programming
% Part 2: Answer Set Programming (ASP) – Family Relationship Reasoning
% This encoding mirrors the Prolog version and also includes a small
% optimization and a choice rule to illustrate multiple answer sets.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Facts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

male(john).
female(mary).
male(bob).
female(alice).
male(charlie).
female(diana).

parent(john, bob).
parent(mary, bob).
parent(bob, alice).
parent(bob, charlie).
parent(alice, diana).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Derived relationships
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

father(F,C) :- male(F), parent(F,C).
mother(M,C) :- female(M), parent(M,C).

sibling(X,Y) :-
    parent(P,X),
    parent(P,Y),
    X != Y.

grandparent(GP,GC) :-
    parent(GP,P),
    parent(P,GC).

ancestor(A,D) :- parent(A,D).
ancestor(A,D) :- parent(A,X), ancestor(X,D).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choice rule for multiple answer sets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each male may or may not live in the city – this creates different
% possible worlds (answer sets).

{ lives_in_city(X) : male(X) }.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simple optimization example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Try to minimize the number of sibling pairs where X<Y.
#minimize { 1,X,Y : sibling(X,Y), X < Y }.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output predicates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#show father/2.
#show mother/2.
#show sibling/2.
#show grandparent/2.
#show ancestor/2.
#show lives_in_city/1.
