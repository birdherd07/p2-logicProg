# Project 2 – Logic Programming: Family Relationship Reasoning

## Overview

This project explores two logic programming paradigms:

- **Part 1 – Prolog:** backward‑chaining, query‑driven reasoning.
- **Part 2 – Answer Set Programming (ASP):** stable‑model, model‑generation style reasoning using `clingo`.

We use the same simple domain in both cases: a **family relationship expert system**.
The knowledge base encodes a small family tree and supports reasoning about:

- `father/2`
- `mother/2`
- `sibling/2`
- `grandparent/2`
- `ancestor/2` (recursive)
- In ASP, an additional fluent `lives_in_city/1` created by a choice rule to show multiple answer sets.

---

## Files

- `family.pl` – Prolog source for Part 1.
- `family.lp` – ASP (clingo) source for Part 2.
- `project2_doc.pdf` – Short documentation / report.

---

## How to run (Prolog)

Using SWI‑Prolog:

```bash
swipl
?- [family].
?- father(john, bob).
?- mother(mary, bob).
?- sibling(alice, charlie).
?- grandparent(john, alice).
?- ancestor(john, diana).
```

You should see `true` for each of the above queries.

---

## How to run (ASP with clingo)

```bash
clingo family.lp
clingo family.lp --out-ifs=\n
```

The output will list answer sets containing facts such as:

- `father(john,bob)`
- `mother(mary,bob)`
- `sibling(alice,charlie)`
- `grandparent(john,alice)`
- `ancestor(john,diana)`
- And different combinations of `lives_in_city(X)` depending on the answer set.

The `#minimize` statement prefers models with fewer sibling pairs (where `X < Y`), so clingo will search for optimal models under that cost function.

---

## Comparison: Prolog vs ASP (short)

- **Execution model**
  - Prolog: answers queries via **backward chaining** (depth‑first search). It only explores the parts of the knowledge base that are relevant to the current query.
  - ASP: computes entire **stable models** (answer sets), then we inspect which atoms are true in each model.

- **Control vs. declarative style**
  - Prolog has an implicit execution order (top‑down, left‑to‑right). Performance can depend on rule ordering.
  - ASP is more declarative; rules describe constraints, and the solver handles the search.

- **Non‑monotonic reasoning**
  - ASP naturally supports non‑monotonic features (e.g., defaults, choice rules, minimization).
  - Prolog can emulate some of this but typically requires extra mechanisms (e.g., cut, negation as failure) and careful control.

Using the *same* family‑relationship rules in both languages highlights these differences in a simple, intuitive domain.
