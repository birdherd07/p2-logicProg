# Project 2 – Logic Programming: Family Relationship Reasoning

## Overview

This project explores two logic programming paradigms on the same domain: a small **family relationship system**.

- **Part 1 – Prolog:** backward-chaining, query-driven reasoning  
- **Part 2 – Answer Set Programming (ASP):** stable-model reasoning using `clingo`

The knowledge base models and reasons about the following relationships:

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

## Files Included

- `family.pl` — Prolog rules (Part 1)
- `family.lp` — ASP rules (Part 2)
- `logic.pl` — Additional Prolog predicates (if used)
- `project2_doc.pdf` — Short documentation/report
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
?- father(john, bob).
?- mother(mary, bob).
?- sibling(alice, charlie).
?- grandparent(john, alice).
?- ancestor(john, diana).
```

All valid queries should return `true`.

---

## How to Run (ASP – clingo)

Basic execution:

```bash
clingo family.lp
```

Show only the optimal model with clean newlines:

```bash
clingo --opt-mode=optN --quiet=1 --out-ifs=\n family.lp
```

Example atoms that may appear in an answer set:

- `parent(john,bob)`
- `mother(mary,bob)`
- `sibling(alice,charlie)`
- `ancestor(john,diana)`
- ASP-specific assignments from choice rules (e.g., `related(X)` vs `unrelated(X)`)

---

## Comparison: Prolog vs ASP

| Feature | Prolog | ASP |
|--------|--------|------|
| Reasoning model | Backward-chaining | Stable model generation |
| Execution style | Goal-directed search | Computes full possible worlds |
| Rule ordering | Affects behavior | Irrelevant |
| Non-monotonic reasoning | Limited, manual | Built-in (defaults, NAF, optimization) |

Using one domain in two paradigms highlights conceptual differences between procedural logic programming and declarative answer-set reasoning.

---

## AI / LLM Usage Documentation (Required)

### ✔ AI tools used
AI assistance (ChatGPT, Perplexity) was used for:

- Drafting and refining Prolog rules
- Translating rules into ASP syntax
- Designing ASP choice rules and constraints
- Writing example queries
- Structuring this README
- Explaining differences between Prolog and ASP
- Clarifying how to run both programs

### ✔ AI tools NOT used for
- Running Prolog or clingo  
- Generating final family facts  
- Producing screenshots or output  
- Debugging the final version  

All debugging, validation, and final decision-making were done manually.

### ✔ Final submission
All code and documentation were reviewed and edited manually to meet project requirements.

---

## Authors

- **Liu** — Prolog rules, ASP translation, full documentation  
- **Rachel & Yogitha** — Team coordination and support

---

## End of README