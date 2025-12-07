% family.lp
% Project 2 – Logic Programming
% Part 2: Answer Set Programming (ASP) – Family Relationship Reasoning
% This encoding mirrors the Prolog version and also includes an optimization for creating a denser family tree.
% It also supports choice rules for unknown individuals and siblings.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Facts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
male(john).
male(bob).
male(charlie).
male(bruce).
female(alice).
female(mary).
female(diana).
female(hellen).

parent(john, bob).
parent(mary, bob).
parent(bob, alice).
parent(bob, charlie).
parent(alice, diana).

unknown(hellen).
unknown(bruce).

deceased(mary).
deceased(john).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Derived relationships
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Everyone is a person
person(X) :- male(X).
person(X) :- female(X).

% Integrity Constraint: A parent must not be a child of their own child.
:- parent(P, C), parent(C, P).

% Parental constraints: Each child has two parents
:- parent(P1, C), parent(P2, C), parent(P3, C), P1 != P2, P1 != P3, P2 != P3.
:- parent(P1, C), parent(P2, C), male(P1), male(P2), P1 != P2.
:- parent(P1, C), parent(P2, C), female(P1), female(P2), P1 != P2.

% A child is the opposite of parent
child(C, P) :- parent(P, C).
:- child(P1, P2), child(P2, P1).

father(F,C) :- male(F), parent(F,C).
mother(M,C) :- female(M), parent(M,C).

% Spousal relationship: If two people have a common child, they are married.
married(P1, P2) :- parent(P1, C), parent(P2, C), P1 != P2.

sibling(X,Y) :- parent(P,X), parent(P,Y), X != Y.

grandparent(GP,GC) :- parent(GP,P), parent(P,GC).

% Ancestor: recursive definition
ancestor(A,D) :- parent(A,D).
ancestor(A,D) :- parent(A,X), ancestor(X,D).

% Unrelated constraints: If a person is unrelated, they have no ties in the family tree.
unrelated(P) :- person(P), not married(P, _), not parent(P, _), not child(P, _).
:- parent(P, _), unrelated(P).
:- married(P, _), unrelated(P).
:- child(_, P), unrelated(P).

% NAF logic: Living ancestors
living_ancestor(X, Y) :- ancestor(X, Y), not deceased(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choice rule for multiple answer sets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unknown person assignment choice: Unknown people can be assigned as parents to children with an unknown parent
% or assigned as unrelated to the family tree.
{ parent(P,C) : person(P2), parent(P2, C), P2 != P ; unrelated(P) } :- unknown(P).

% Eldest sibling choice: Each sibling may or may not be the oldest – this creates different
% possible worlds (answer sets).
1 { eldest_sibling(C, X) } 1 :- parent(X, C), sibling(C, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optimization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find the stable model that maximizes the sum of all weights.
% This will prefer models with more parent relationships (denser family tree).
#maximize { 1, P, C : parent(P, C)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output predicates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%#show child/2.
%#show parent/2.
%#show father/2.
%#show mother/2.
%#show married/2.
%#show sibling/2.
%#show grandparent/2.
%#show ancestor/2.
%#show living_ancestor/2.
%#show eldest_sibling/2.
%#show unrelated/1.