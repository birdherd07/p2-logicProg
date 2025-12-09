# Project 2 – Logic Programming: Family Relationship Reasoning

## Authors

- **Liu** — Prolog rules, ASP translation
- **Rachel** — ASP Optimization, Choice rules, Prolog display
- **Yogitha** — Team coordination and support

---

## Overview

This project explores two logic programming paradigms:

- **Part 1 – Prolog:** backward‑chaining, query‑driven reasoning.
- **Part 2 – Answer Set Programming (ASP):** stable‑model, model‑generation style reasoning using `clingo`.

We use the same simple domain in both cases: a **family relationship system**.
The knowledge base encodes a small family tree and supports reasoning about:

- `child/2`
- `parent/2`
- `father/2`
- `mother/2`
- `married/2`
- `sibling/2`
- `grandparent/2`
- `ancestor/2` (recursive)
- `living_ancestor/2` (ASP only, using negation-as-failure)
---

## Files

- `family.pl` – Prolog source for Part 1.
- `family.lp` – ASP (clingo) source for Part 2.
- `project2_doc.pdf` – Short documentation / report.
- `README.md` — This file

---

## How to Run (Prolog – SWI-Prolog)

Open a terminal inside the `p2-logicProg` folder:

```bash
swipl
?- [family].
```

Example queries:

```prolog
swipl
?- [family].
?- family_tree.
?- father(john, bob).
?- mother(mary, bob).
?- sibling(alice, charlie).
?- grandparent(john, alice).
?- ancestor(john, diana).
?- living_ancestor(bob, alice).
```

You should see `true` for each of the above queries.

---

## How to run (ASP with clingo)

```bash
clingo family.lp
```

Show only the optimal model with clean newlines:

```bash
clingo --opt-mode=optN --quiet=1 --out-ifs=\n family.lp
```

The output can list answer sets containing facts such as:

- `father(john,bob)`
- `mother(mary,bob)`
- `sibling(alice,charlie)`
- `grandparent(john,alice)`
- `ancestor(john,diana)`
- In ASP, additional fluents `eldest_sibling` and assignment of unknown individuals to `parent` or `unrelated` are created by choice rules to show multiple answer sets.
- In ASP, an optimization #maximize favors assignment to `parent` over `unrelated` to create a fuller family tree model.

---

## Comparison: Prolog vs ASP

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

## AI/LLM Usage Documentation

### Tools Used
- **ChatGPT**: 
  - Drafting and refining Prolog rules
  - Translating rules into ASP syntax
  - Designing ASP choice rules and constraints
  - Writing example queries
  - Structuring this README
  - Explaining differences between Prolog and ASP
  - Clarifying how to run both programs
- **Perplexity**: 
  - Design of ASP choice rules
  - Design of ASP constraints

## Specific AI assistance

#### Choice Rules
- **Prompt**: "What is the best way to design a choice rule stating that an unknown person can either be a family member or unrelated?"
- **AI Response**: Use a choice rule with a two‑atom head and, if needed, constraints to enforce the “either family member or unrelated” behavior.
- **Modification**: Modified example provided to match existing predicates and added constraints.

#### Constraints
- **Prompt**: "How can I write a constraint rule that forbids a child from having more than two parents?"
- **AI Response**: Use a cardinality constraint on the parent/2 predicate, or if you do not have a child\1 predicate, then quantify over all persons as potential children.
- **Modification**: Altered choice rule structure to regular rule structure for simplicity.

## Practical Usage
- **Familial organization**: Both programs provide answers to queries about familial relationships between people.
- **Family tree visualization**: family.pl displays the family tree visually for easier understanding.
- **Family tree assignment**: family.lp assigns unknown individuals to vacant spaces in a family tree, providing multiple possible worlds of how a person could be related to the existing tree.
  
