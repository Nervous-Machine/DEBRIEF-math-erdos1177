# DEBRIEF-math-erdos1177

A DEBRIEF mission record (protocol https://github.com/Nervous-Machine/DEBRIEF) for **The claimed solution of Erdős Problem #1177 (three statements about triple systems avoiding a fixed finite one)**.

This claim is on the public claims board, https://math-board.nervousmachine.com, which shows its stage, who has contributed, and what it needs next.

**Standing.** Certified 0. Accepted 0. Refuted 0. Open gaps 3. This record is at tier zero: the claim and its public artifacts are pinned, the checks still owed are listed, and nothing has been run or read yet. The first contribution is open.

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
2. **Do the formal statements say what the problem asks?** (EG2): A reading of the formal statement against the problem as posed, by someone who did not write it.
3. **No independent mathematician has reported reading the proof, and there is no referee report** (EG3): Someone in the field reads it and says, under their name, what holds and what does not.

## Contributing

- **Rerun** (if there is a Lean development): copy `prereg_rerun.yaml`, fill in your predictions, register it with `tools/prereg.py register` from the protocol repository and commit it *before* running anything. Run. Report with the **Rerun report** issue form; it becomes a `rerun` cycle under your name.
- **Read**: a trace (reading guide) does not exist yet. Writing one is itself a `trace` cycle. Once it exists, the **Semantic read** form takes signatures and refusals.
- **Anything else**: open a plain issue.

Rules and templates: https://github.com/Nervous-Machine/DEBRIEF/blob/main/CONTRIBUTING.md. Every contribution is one dated cycle under your own name and goes into `CITATION.cff` and the next release.

## Layout

```
ledger/erdos1177.json   the ledger (protocol 0.1.0)
claim.yaml            the pinned claim this record was opened from
SCORECARD.md / ASKS.md  generated from the ledger
prereg_rerun.yaml     a pre-registration template for the first rerun (unregistered)
cycles/               contributed cycles, one file each
```

## Words

This record never calls the claim proved, verified or a theorem. It records what was claimed, what was checked by whom under what rule, and what is still open. Nothing here has standing until a cycle gives it one.
