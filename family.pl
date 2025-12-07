% family.pl
% Project 2 – Logic Programming
% Part 1: Prolog – Family Relationship Reasoning System
% Author: Xun Liu, Rachel, Yogitha
%
% This Prolog program represents a small family tree and supports
% reasoning about relationships such as father, mother, sibling,
% grandparent, and ancestor.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Facts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

male(john).
male(bob).
male(charlie).
female(alice).
female(mary).
female(diana).

parent(john, bob).
parent(mary, bob).
parent(bob, alice).
parent(bob, charlie).
parent(alice, diana).

alive(bob).
alive(charlie).
alive(alice).
alive(diana).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Derived relationships
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Everyone is a person
person(X) :- male(X).
person(X) :- female(X).

child(C, P) :- parent(P, C).

% father(Father, Child) :- Father is a male parent of Child.
father(F, C) :-
    male(F),
    parent(F, C).

% mother(Mother, Child) :- Mother is a female parent of Child.
mother(M, C) :-
    female(M),
    parent(M, C).

married(P1, P2) :- parent(P1, C), parent(P2, C), P1 \= P2.

% sibling(X, Y) :- X and Y share at least one parent and are different people.
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

% grandparent(GP, GC) :- GP is a parent of a parent of GC.
grandparent(GP, GC) :-
    parent(GP, P),
    parent(P, GC).

% ancestor(Ancestor, Descendant) – recursive definition.
ancestor(A, D) :-
    parent(A, D).

ancestor(A, D) :-
    parent(A, X),
    ancestor(X, D).

% Non-NAF logic: Living ancestors

living_ancestor(X, Y) :-  alive(X), ancestor(X, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sample queries (for documentation)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ?- father(john, bob).
% ?- mother(mary, bob).
% ?- married(john, mary).
% ?- sibling(alice, charlie).
% ?- grandparent(john, alice).
% ?- ancestor(john, diana).
% ?- living_ancestor(bob, alice).