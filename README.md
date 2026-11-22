# DEBRIEF-math-erdos1177

A DEBRIEF mission record (protocol https://github.com/Nervous-Machine/DEBRIEF) for **The claimed solution of Erdős Problem #1177 (three statements about triple systems avoiding a fixed finite one)**.

This claim is on the public claims board, https://math-board.nervousmachine.com, which shows its stage, who has contributed, and what it needs next.

<!-- standing:begin -->
**Standing, 17 Nov 2026.** Stage: Reading guide written. Needs next: The Lean development has not been built or kernel-checked by anyone outside the claimant ([what would close it](ASKS.md)).

| certified | accepted | refuted | open gaps | cycles filed | last cycle |
|---|---|---|---|---|---|
| 0 | 0 | 0 | 3 | 1 | 17 Nov 2026 |

| | |
|---|---|
| checked by machine | nobody yet |
| read by a person | nobody yet; [reading guide](trace/DEFINITIONAL-TRACE.md) |
| elsewhere | [DeepMind formal-conjectures](https://github.com/google-deepmind/formal-conjectures/blob/6751c0f043985ac6647db28a45a63afdf21acffe/FormalConjectures/ErdosProblems/1177.lean): solved · [erdosproblems.com](https://www.erdosproblems.com/): open |
| related | [Erdős #593](https://github.com/Nervous-Machine/DEBRIEF-math-erdos593): resolved in the same paper (arXiv:2606.24882); same claimant · same claimant: [Erdős #550](https://github.com/Nervous-Machine/DEBRIEF-math-erdos550), [Erdős #731](https://github.com/Nervous-Machine/DEBRIEF-math-erdos731), [Erdős #768](https://github.com/Nervous-Machine/DEBRIEF-math-erdos768) |
| tooling | GPT-5.5 Pro · tier: subscription-pro (stated by the claimant: GPT-5.5 Pro, a model of the ChatGPT Pro, Business and Enterprise tiers) |

Rendered from `ledger/` at regeneration; the full record is `SCORECARD.md`, what is owed is `ASKS.md`. Standing words: nothing has standing yet.
<!-- standing:end -->

## The problem

For a finite 3-uniform hypergraph G and a cardinal kappa, let F(G, kappa) be the 3-uniform hypergraphs of chromatic number kappa that do not contain G. Three statements: if F(G, aleph-one) is non-empty it contains one of size at most two to the power two to the power aleph-null; if F(G, aleph-one) and F(H, aleph-one) are both non-empty so is their intersection; and if kappa and lambda are uncountable and F(G, kappa) is non-empty then so is F(G, lambda).

Source: https://www.erdosproblems.com/1177 (posed: Erdős, Galvin and Hajnal; listed in Vaughan's problem collection (1999)).

A third-party formalization of the problem statement exists: `FormalConjectures/ErdosProblems/1177.lean` in github.com/google-deepmind/formal-conjectures at commit `e028240a61822d970c933f4656f51da025cf200b` (blob `d1d8f93315cc0689e4808cb103bb6818a0ee878b`). It is the natural reference for whether a claimant's Lean theorem states this problem.

## The claim

**Eric Li**, using GPT-5.5 Pro (as listed by the claimant), submitted 2026-07-17 at https://www.erdosproblems.com/forum/thread/1177/proof-claims.

The same paper that claims problem 593 claims that its characterisation of obligatory triple systems, together with a construction of linear triple systems of every uncountable chromatic number with a size bound, settles the three statements of problem 1177 as yes, no and yes.

Artifacts, pinned:

- an arXiv preprint: arXiv:2606.24882v2 "A Resolution of Erdős Problems 593 and 1177: Obligatory Triple Systems and Exact Spectra" (published 2026-06-23, last revised 2026-07-23)
- a public repository: github.com/ericlisg/erdos-593-1177-lean at commit 5dcb6e4906df03f2e4294b21be73b55db7736f5a (2026-07-23); licence Apache-2.0; 65 Lean files; has a lakefile

Status on the problem page as of 2026-11-14: listed as one proof claim; not marked accepted by the site.

## What is owed

Each open gap is in `ASKS.md` with what closes it and who could act. In order:

1. **The Lean development has not been built or kernel-checked by anyone outside the claimant** (EG1): A rerun of the Lean build on an independent machine, written down first.
2. **Do the formal statements say what the problem asks?** (EG2): A set theorist who is not an author reads `trace/DEFINITIONAL-TRACE.md` against the formal statements and the problem page and signs or refuses its five checklist lines, starting with C1: does a "no" for chromatic number exactly ℵ₁ answer the second assertion as Erdős, Galvin and Hajnal posed it? (Anomaly A1: the claimant's paper says the 1999 wording was "uncountably chromatic", for which the exact-ℵ₁ "no" is the weaker refutation.) Two independent signatures close this gap.
3. **No independent mathematician has reported reading the proof, and there is no referee report** (EG3): Someone in the field reads it and says, under their name, what holds and what does not.

## Contributing

- **Rerun** (if there is a Lean development): copy `prereg_rerun.yaml`, fill in your predictions, register it with `tools/prereg.py register` from the protocol repository and commit it *before* running anything. Run. Report with the **Rerun report** issue form; it becomes a `rerun` cycle under your name.
- **Read**: the reading guide is `trace/DEFINITIONAL-TRACE.md` (cycle 1). It quotes the problem, the third-party formal statements and the claimant's own, traces every symbol to its definition, and ends with a five-line checklist. Sign or refuse it with the **Semantic read** issue form; your answers become a `read` cycle under your name. Two independent signatures close gap EG2. The worked examples in `cycles/trace-1/Trace.lean` have not been run; running them and committing the transcript is a welcome contribution.
- **Anything else**: open a plain issue.

Rules and templates: https://github.com/Nervous-Machine/DEBRIEF/blob/main/CONTRIBUTING.md. Every contribution is one dated cycle under your own name and goes into `CITATION.cff` and the next release.

## Layout

```
ledger/erdos1177.json   the ledger (protocol 0.1.0)
claim.yaml            the pinned claim this record was opened from
SCORECARD.md / ASKS.md  generated from the ledger
prereg_rerun.yaml     a pre-registration template for the first rerun (unregistered)
prereg_trace.yaml     the pre-registration of cycle 1, the reading guide (hashed)
trace/                the reading guide for the semantic question (cycle 1)
cycles/               contributed cycles, one file each
```

## Words

This record never calls the claim proved, verified or a theorem. It records what was claimed, what was checked by whom under what rule, and what is still open. Nothing here has standing until a cycle gives it one.
