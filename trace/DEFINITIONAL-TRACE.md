# Definitional trace of the formal statements of Erdős Problem #1177

**For:** a mathematician in infinite combinatorics willing to spend thirty to forty-five minutes deciding whether the
formal statements of Erdős Problem #1177 say what Erdős, Galvin and Hajnal asked, and whether each of the claimed
answers (yes, no, yes) is attached to the right one. That is the one question on this record that no machine settles.
Unlike some records in this register, nothing downstream of it has been checked by machine here yet either: the
claimant's Lean development has not been built by anyone independent (gap EG1).

**What this is.** The three assertions as posed, the two formal versions of them verbatim (the third-party one in
formal-conjectures and the claimant's own), every definition they depend on down to Mathlib and Lean core with file and
line, a plain-language rendering of each piece, the places where the formal versions and the problem differ, and a
sign-off checklist. The renderings are the reading of the operating agent (Claude Code, for Nervous Machine) on
17 November 2026. They are an aid, not a check.

**What this is not.** Not an independent human semantic review, and it changes no standing. Gap EG2 stays open until a
person who is not an author signs the checklist at the end. It is not a build: nothing was built, run or executed for
this trace, including the worked examples (Part D), which are written but **not yet run by Lean**. It says nothing
about the paper's argument (gap EG3).

**Sources, pinned, all fetched read-only by commit.**
- Formal statement (third party): `FormalConjectures/ErdosProblems/1177.lean` in google-deepmind/formal-conjectures at
  `e028240a61822d970c933f4656f51da025cf200b` (blob `d1d8f933`, file sha256 `105197f9a35ba1d9493978363b7a2ed61332defebae910591278d03eaec3f0e3`),
  with its hypergraph library `FormalConjecturesForMathlib/Combinatorics/Hypergraph/{Basic,Uniform}.lean` at the same
  commit. That repository pins Lean `v4.33.1` and Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`.
- Claimant's statements: github.com/ericlisg/erdos-593-1177-lean at `5dcb6e4906df03f2e4294b21be73b55db7736f5a`, files
  `RequestProject/PublicationCertificate.lean` (sha256 `60b4c304…`), `FinalResultsUnconditional.lean` (`ab322435…`),
  `Defs.lean` (`ae35f016…`), `Lift.lean` (`976b2c7c…`), and `paper.tex` (`aa62c091…`). That repository pins Lean
  `v4.28.0` and Mathlib `8f9d9cff6bd728b17a24e163c9402775d9e6a365` (from its `lake-manifest.json`).
- Problem page: https://www.erdosproblems.com/1177 as read on 2026-11-17 (page last edited 23 January 2026; its history
  page shows only the current version).
- Pre-registration for this trace: `prereg_trace.yaml` (hashed and committed before any definition was read).

---

## 0. Conventions a reviewer has to know

| convention | where | what it means here |
|---|---|---|
| Two independent formalisations | formal-conjectures (FC) and the claimant (CL) | FC builds on Mathlib's `Hypergraph`; CL defines its own `Erdos593.Hypergraph`. They pin different Mathlib revisions, and Mathlib's `Hypergraph` file does not exist at CL's revision. Nothing links them by machine (D2). |
| A hypergraph's vertices are its whole type | FC `Uniform.lean` l.42–46 (`vertexSet_eq_univ`); CL `Lift.lean` l.37–38 (only `edges : Set (Set V)`) | isolated vertices count as vertices, in the host and in the forbidden `G` |
| Weak colouring | FC `Basic.lean` l.37–38; CL `Lift.lean` l.42–44 | both: `∀ e ∈ edges, ∃ u ∈ e, ∃ v ∈ e, f u ≠ f v`, i.e. no monochromatic edge |
| FC chromatic cardinal is an infimum, 0 if no colouring | FC `Uniform.lean` l.91–92; Mathlib `Cardinal.sInf_empty` (`SetTheory/Cardinal/Order.lean` l.382 at both revisions) | never bites for 3-uniform systems: the identity map is a proper colouring (FC `chromaticCardinal_le_mk`, l.100) |
| CL chromatic number is "colourable with κ, not with less" | CL `Lift.lean` l.48–56; `θ.out` is a type with `#θ.out = θ` (Mathlib `Cardinal.mk_out`, `SetTheory/Cardinal/Defs.lean` l.116 at 8f9d9cff) | the least κ with a proper colouring into κ colours |
| Containment is injective and not induced | FC `Uniform.lean` l.105–108; CL `Defs.lean` l.73–75 | an injective vertex map sending every edge of `G` to an edge of the host; extra host edges are allowed |
| `ℵ₁` is `aleph 1`; CL also writes `Order.succ ℵ₀` | Mathlib `SetTheory/Cardinal/Aleph.lean`: `aleph` l.370, notation `ℵ₁` l.377, `succ_aleph0 : succ ℵ₀ = ℵ₁` l.462 (8f9d9cff); l.414, 421, 526 (0df444a3) | the first uncountable cardinal, in both |
| Universes | FC: every vertex type is `Type` (universe 0); CL: hosts in `Type u` for arbitrary `u`, finite systems in `Type` | "every uncountable cardinal" means every cardinal of the universe in play (D6) |
| No `answer(...)` wrapper | FC `1177.lean` l.43–74 at the pinned commit | the answers are hard-coded: parts i and iii are stated as true, part ii is stated with a leading `¬` (D3) |

---

## Part A. The problem as posed

**A1. The problem page**, verbatim (erdosproblems.com/1177, citing [Va99, 7.94], "A problem of Erdős, Galvin, and Hajnal"):

> Let $G$ be a finite $3$-uniform hypergraph, and let $F_G(\kappa)$ denote the collection of $3$-uniform hypergraphs with
> chromatic number $\kappa$ not containing $G$. If $F_G(\aleph_1)$ is not empty then there exists $X\in F_G(\aleph_1)$ of
> cardinality at most $2^{2^{\aleph_0}}$. If both $F_G(\aleph_1)$ and $F_H(\aleph_1)$ are non-empty then
> $F_G(\aleph_1)\cap F_H(\aleph_1)$ is non-empty. If $\kappa,\lambda$ are uncountable cardinals and $F_G(\kappa)$ is
> non-empty then $F_G(\lambda)$ is non-empty.

Call these assertions (1), (2), (3). Each is implicitly "for all finite $G$" (and $H$).

**A2. The claimant's own account of the source** (`paper.tex` l.268–271, verbatim):

> The 1999 booklet phrased the first two clauses of Problem~\#1177 for uncountably chromatic systems, while the current
> record asks for exact chromatic number $\aleph_1$. The corollary proves the exact version and therefore also implies
> the corresponding uncountable versions.

**What the trace does not check.** The operating agent did not consult Vaughan's 1999 booklet or the 1975
Erdős–Galvin–Hajnal paper, so it cannot say which wording is the problem. It takes the page's wording as the problem
and records the claimant's account of the older wording as discrepancy D1, which matters for assertion (2) only.

---

## Part B. The formal statements, verbatim

**B1. formal-conjectures** (`FormalConjectures/ErdosProblems/1177.lean` at the pinned commit, namespace `Erdos1177`,
`open Cardinal Filter Asymptotics`; each proof is `sorry` there because the file states the problem, it does not
solve it; each is tagged `@[category research solved, AMS 3 5]`):

```lean
theorem erdos_1177.parts.i :                                               -- l.43–49
    ∀ (W : Type) [Fintype W] (G : UniformHypergraph W 3),
    G.HasAvoidingChromaticCardinal ℵ₁ →
      ∃ (V : Type) (_ : DecidableEq V) (X : UniformHypergraph V 3),
        X.chromaticCardinal = ℵ₁ ∧ ¬ G.Appears X ∧
          Cardinal.mk V ≤ (2 : Cardinal) ^ ((2 : Cardinal) ^ ℵ₀)

theorem erdos_1177.parts.ii :                                              -- l.57–63
    ¬ ∀ (W U : Type) [Fintype W] [Fintype U]
    (G : UniformHypergraph W 3) (H : UniformHypergraph U 3),
    G.HasAvoidingChromaticCardinal ℵ₁ → H.HasAvoidingChromaticCardinal ℵ₁ →
      ∃ (V : Type) (_ : DecidableEq V) (X : UniformHypergraph V 3),
        X.chromaticCardinal = ℵ₁ ∧ ¬ G.Appears X ∧ ¬ H.Appears X

theorem erdos_1177.parts.iii :                                             -- l.70–74
    ∀ (W : Type) [Fintype W] (G : UniformHypergraph W 3)
    (κ μ : Cardinal), ℵ₀ < κ → ℵ₀ < μ →
      G.HasAvoidingChromaticCardinal κ → G.HasAvoidingChromaticCardinal μ
```

The docstrings cite [Li26, Corollary 1.4(1)–(3)]. The `research solved` tags are a repository label resting on the
claimant's paper; there is no Lean proof of these three statements in formal-conjectures or, as far as the agent can
see, anywhere public (D2).

**B2. The claimant's statements** (`RequestProject/PublicationCertificate.lean` l.37–62, the fields of the structure
`FullResolution`, whose claimed proof term is `full_resolution_unconditional` at l.67; universe `u`):

```lean
  part1 : ∀ (G : FTS), G.FGnonempty (Cardinal.aleph 1 : Cardinal.{u}) →
    ∃ (W : Type u) (H : Hypergraph W),
      H.IsTripleSystem ∧
      H.HasChromatic (Cardinal.aleph 1 : Cardinal.{u}) ∧
      ¬ G.Embeds H ∧
      #W ≤ (2 : Cardinal.{u}) ^ ((2 : Cardinal.{u}) ^ (ℵ₀ : Cardinal.{u}))
  part2 : ∃ (G H : FTS),
    G.FGnonempty (Cardinal.aleph 1 : Cardinal.{u}) ∧
    H.FGnonempty (Cardinal.aleph 1 : Cardinal.{u}) ∧
    ¬ ∃ (W : Type u) (K : Hypergraph W),
      K.IsTripleSystem ∧
      K.HasChromatic (Cardinal.aleph 1 : Cardinal.{u}) ∧
      ¬ G.Embeds K ∧ ¬ H.Embeds K
  part3 : ∀ (G : FTS) (kappa : Cardinal.{u}), ℵ₀ < kappa →
    G.FGnonempty kappa → ∀ (lam : Cardinal.{u}), ℵ₀ < lam → G.FGnonempty lam
```

The fields are filled from `problem_1177_part1_aleph_one`, `problem_1177_part2_aleph_one` and
`problem_1177_part3_unconditional` (`FinalResultsUnconditional.lean` l.52, l.67; part 2 via l.119, stated with
`Order.succ ℵ₀`). The claimant reports that `#print axioms` gives `propext, Classical.choice, Quot.sound`; nobody
independent has checked that (EG1).

**B3. The bridge.** There is none. The claimant's repository never mentions formal-conjectures, and the two use
different hypergraph types on different Mathlib revisions. A reviewer who accepts B1 as the problem must separately
accept that B2 says the same thing; Part C lays the definitions side by side for that.

---

## Part C. Every piece, traced

### C1. The definitions

| notion | formal-conjectures (FC) | claimant (CL) | agent's reading |
|---|---|---|---|
| finite 3-uniform $G$ | `W : Type`, `[Fintype W]`, `G : UniformHypergraph W 3`; `UniformHypergraph` extends Mathlib `Hypergraph` (`Mathlib/Combinatorics/Hypergraph/Basic.lean` l.73–79 at 0df444a3: `vertexSet`, `edgeSet : Set (Set α)`, edges inside vertices) with `vertexSet = univ` and `IsUniform 3` (`Basic.lean` l.33: `e.encard = k`) | `FTS` (`Defs.lean` l.50–58): `V : Type`, `Fintype V`, `DecidableEq V`, `edges : Finset (Finset V)`, `card3 : ∀ e ∈ edges, e.card = 3` | "a finite vertex set with a family of 3-element subsets"; the same data in both |
| 3-uniform host $X$ | `UniformHypergraph V 3`, `V : Type` | `H : Hypergraph W` (`Lift.lean` l.37–38) with `IsTripleSystem` (`Defs.lean` l.38–39: `∀ e ∈ H.edges, e.ncard = 3`) | "a set with a family of 3-element subsets". `ncard` of an infinite set is 0 (Mathlib `Data/Set/Card.lean` l.570), so `ncard = 3` and `encard = 3` both mean "exactly three elements". |
| proper colouring | `Hypergraph.IsProperColoring` (`Basic.lean` l.37–38) | `Hypergraph.ProperColoring` (`Lift.lean` l.42–44) | identical text: every edge has two vertices of different colour (weak colouring) |
| chromatic number $=\kappa$ | `X.chromaticCardinal = κ`, where `chromaticCardinal := sInf {κ \| ∃ C : Type u, #C = κ ∧ ∃ f : V → C, IsProperColoring f}` (`Uniform.lean` l.91–92) | `HasChromatic κ := ColorableBy κ ∧ ∀ θ < κ, ¬ ColorableBy θ`, `ColorableBy θ := ∃ c : V → θ.out, ProperColoring c` (`Lift.lean` l.48–56) | both: "the least number of colours in a proper colouring is exactly κ". For a non-empty vertex set, colourability is upward closed in the number of colours, so "colourable with κ and not with less" is "the least is κ". |
| $X$ does not contain $G$ | `¬ G.Appears X`, `Appears := ∃ φ : W → V, Injective φ ∧ (F.toHypergraph.image φ).edgeSet ⊆ H.edgeSet` (`Uniform.lean` l.105–108; Mathlib `Hypergraph.image` l.156–158: edges are the images `f '' e`) | `¬ G.Embeds X`, `Embeds := ∃ f : F.V → W, Injective f ∧ ∀ e ∈ F.edges, f '' e ∈ H.edges` (`Defs.lean` l.73–75) | both: "no injective map of $G$'s vertices carries every edge of $G$ onto an edge of $X$" (not induced) |
| $F_G(\kappa) \neq \emptyset$ | `G.HasAvoidingChromaticCardinal κ := ∃ (V : Type u) (_ : DecidableEq V) (H : UniformHypergraph V k), H.chromaticCardinal = κ ∧ ¬ F.Appears H` (`Uniform.lean` l.125–128) | `G.FGnonempty κ := ∃ (W : Type u) (H : Hypergraph W), H.IsTripleSystem ∧ H.HasChromatic κ ∧ ¬ G.Embeds H` (`Defs.lean` l.91–93) | both: "some 3-uniform hypergraph of chromatic number exactly κ omits $G$" |
| size | `Cardinal.mk V` | `#W` | the number of vertices, isolated ones included |
| $\aleph_0$, $\aleph_1$, $2^{2^{\aleph_0}}$ | `ℵ₀ = lift #ℕ` (`Cardinal/Defs.lean` l.478 at 0df444a3), `ℵ₁ = aleph 1` (`Aleph.lean` l.421); `^` is cardinal power | same, at 8f9d9cff (l.476, l.377) | the usual cardinals and cardinal exponentiation |

### C2. The three statements, piece by piece

| assertion as posed | FC | CL | agent's reading |
|---|---|---|---|
| (1) for every finite $G$: if $F_G(\aleph_1)\ne\emptyset$ then some $X \in F_G(\aleph_1)$ has $\lvert X\rvert \le 2^{2^{\aleph_0}}$ | parts.i: `∀ W G, HasAvoiding… ℵ₁ → ∃ V X, chromaticCardinal X = ℵ₁ ∧ ¬ G.Appears X ∧ #V ≤ 2^(2^ℵ₀)` | part1: `∀ G, FGnonempty ℵ₁ → ∃ W H, IsTripleSystem ∧ HasChromatic ℵ₁ ∧ ¬ G.Embeds H ∧ #W ≤ 2^(2^ℵ₀)` | the same sentence in both; the answer "yes" is "this holds" |
| (2) for all finite $G, H$: if $F_G(\aleph_1)$ and $F_H(\aleph_1)$ are non-empty then $F_G(\aleph_1)\cap F_H(\aleph_1)\ne\emptyset$ | parts.ii: `¬ ∀ W U G H, HasAvoiding G ℵ₁ → HasAvoiding H ℵ₁ → ∃ V X, chromaticCardinal X = ℵ₁ ∧ ¬ G.Appears X ∧ ¬ H.Appears X` | part2: `∃ G H, FGnonempty G ℵ₁ ∧ FGnonempty H ℵ₁ ∧ ¬ ∃ W K, IsTripleSystem ∧ HasChromatic ℵ₁ ∧ ¬ G.Embeds K ∧ ¬ H.Embeds K` | FC is literally "not (assertion 2)". CL is its classical equivalent: there are $G, H$ with both families non-empty and no common member. Both hypotheses are kept; the quantifiers are in the right order (D4). The answer "no" is "assertion 2 is false". |
| (3) for every finite $G$ and uncountable $\kappa, \lambda$: $F_G(\kappa)\ne\emptyset \Rightarrow F_G(\lambda)\ne\emptyset$ | parts.iii: `∀ W G κ μ, ℵ₀ < κ → ℵ₀ < μ → HasAvoiding κ → HasAvoiding μ` | part3: `∀ G κ, ℵ₀ < κ → FGnonempty κ → ∀ λ, ℵ₀ < λ → FGnonempty λ` | the same sentence; "uncountable" is `ℵ₀ < κ` |

---

## Part D. Worked examples, written but not yet run

`cycles/trace-1/Trace.lean` holds the commands. **None has been run by Lean.** Nothing below is a result; each line says
what the command is meant to show, and a person who runs it can confirm or refute that and commit the transcript as
`cycles/trace-1/trace.txt`. Part 1 of the file runs inside the claimant's development; Part 2 inside formal-conjectures.

1. `#print` / `#check` of the three CL statements, `FullResolution`, and every CL definition in C1, plus
   `#print axioms full_resolution_unconditional` (the claimant reports the three standard axioms).
2. `Order.succ ℵ₀ = Cardinal.aleph 1` by `Cardinal.succ_aleph0` (D9).
3. `#θ.out = θ` by `Cardinal.mk_out`: the colour type in `ColorableBy θ` has θ elements.
4. An exact-ℵ₁-chromatic system is not colourable with ℵ₀ colours (`h.2 ℵ₀ aleph0_lt_aleph_one`).
5. CL part2's ∃-form is equivalent to "not (assertion 2)" in ∀-form, with both non-emptiness hypotheses kept (D4).
6. The paper's $G$ for part 2, two triples sharing a pair, as an `FTS` on `Fin 4`, and a check that it is not linear.
7. `Part2Uncountable`: the 1999-booklet form of the "no" written as a Lean proposition, with no proof, so a reader can
   see exactly what is not among the headline statements (D1).
8. In formal-conjectures: `#check` of parts i–iii, `#print axioms` of part ii (expected to list `sorryAx`), `#print` of
   each FC definition, `sInf ∅ = 0`, `chromaticCardinal ≤ #V` for 3-uniform systems (D5), and part iii's universe (D6).

---

## Part E. Discrepancies and observations

| id | observation | kind | effect, in the agent's reading |
|---|---|---|---|
| D1 | The page, FC and CL all read assertion (2) for chromatic number **exactly** ℵ₁. The claimant's paper says the 1999 booklet put the first two clauses for **uncountably chromatic** systems (A2). For the "yes" clauses the exact form is the stronger one: (1) in booklet form follows from FC parts i and iii together. For the "no" clause it is the weaker one: "no exact-ℵ₁ system avoids both $G$ and $H$" does not by itself exclude an uncountably chromatic system of larger chromatic number avoiding both. Neither formal statement states the booklet's "no". | problem version | **none against the page; could change the meaning of the "no" if the problem is the booklet's wording.** The paper's own argument for part 2 (`paper.tex` l.2045–2051) appears to give the stronger "no" through the Hajnal–Komjáth fact that every uncountably chromatic linear triple system contains the loose 7-cycle, which CL states as `e5_HK_loose7` with a claimed Lean proof (`E5HK.lean` l.838; `FTS.LinearlyObligatory`, `External.lean` l.183–185). So the gap looks closable in a few lines, but no Lean statement closes it and nobody has checked it. Anomaly A1. |
| D2 | No machine link between FC and CL. They are independent formalisations on different Mathlib revisions (0df444a3, Lean v4.33.1 vs 8f9d9cff, Lean v4.28.0); Mathlib's `Hypergraph` file, which FC uses, is absent at CL's revision. FC's `research solved` tags rest on the paper, not on a Lean proof of FC's statements. | provenance | none on meaning, in the agent's reading (C1 lines up definition by definition), but the agreement is a human reading, not a kernel check. A machine bridge would need a port of one side to the other's library. |
| D3 | FC has no `answer(...)` wrapper at this commit: the answers are hard-coded, with part ii stated as `¬ ∀ …`. | encoding | none; a reader sees directly that FC's "no" is a negation. |
| D4 | The "no": FC writes `¬ ∀ G H, A G → A H → ∃ X, …`; CL writes `∃ G H, A G ∧ A H ∧ ¬ ∃ X, …`. | logic | none: classically equivalent (Part D, example 5); both keep both non-emptiness hypotheses and quantify $G, H$ outside. |
| D5 | Chromatic number: FC uses an infimum that is 0 when no colouring exists; CL uses "colourable with κ, not with less". | definition | none for 3-uniform systems and uncountable κ: a proper colouring always exists, and both pick out the least number of colours. |
| D6 | Universes: FC fixes every vertex type and cardinal in universe 0; CL is universe-polymorphic in the host, with finite systems in universe 0. | Lean convention | none in the agent's reading: CL at `u = 0` matches FC; "every uncountable cardinal" in (3) is read inside one universe, which is how set theory is usually formalised in Lean. |
| D7 | Size is the cardinality of the vertex type, isolated vertices included; the page says "cardinality". | convention | none: deleting isolated vertices changes neither the chromatic number nor what the system contains, so a bound on all vertices and a bound on the vertices that lie on edges ask the same question. |
| D8 | FC's existentials carry a `DecidableEq V` witness. | Lean convention | none: classically every type has one. |
| D9 | CL's underlying theorems use `Order.succ ℵ₀`; the certificate uses `aleph 1`. | notation | none: Mathlib `Cardinal.succ_aleph0` (Part D, example 2), and the certificate states `aleph 1` literally. |
| D10 | Isolated vertices of $G$ and edgeless $G$. | boundary case | none: an injective map from a finite $G$ into an infinite host always exists, so an edgeless $G$ is in every host and $F_G(\kappa)$ is empty for uncountable κ in both formalisations, as on the page. |

One discrepancy (D1) could change the meaning of the "no" answer, depending on which wording is Problem 1177. It is
opened as anomaly A1 in the ledger. No other discrepancy changes the meaning in the agent's reading.

---

## Part F. Sign-off checklist

For a reviewer who is prepared to put their name to a reading. Each line is a yes/no. Send it with the **Semantic read**
issue form on this repository (it becomes a `read` cycle under your name), or anywhere public; the ledger records it by
date. Two independent signatures with no refusal close gap EG2; one refusal reopens it.

- [ ] C1: A "no" for chromatic number exactly ℵ₁ answers assertion (2) as Erdős, Galvin and Hajnal posed it; or, if
  they meant uncountably chromatic systems, the paper's part 2 argument (loose 7-cycle, Hajnal–Komjáth) also gives that
  stronger "no" (D1).
- [ ] A1: FC parts.i is assertion (1) (D5, D6, D7, D10).
- [ ] A2: FC parts.ii is the negation of assertion (2), with both hypotheses kept and $G, H$ quantified outside (D3, D4, D8).
- [ ] A3: FC parts.iii is assertion (3) (D6).
- [ ] B1: CL's `FGnonempty`, `HasChromatic`, `Embeds`, `IsTripleSystem` and `FTS` mean the same as FC's
  `HasAvoidingChromaticCardinal`, `chromaticCardinal`, `Appears`, `UniformHypergraph _ 3` (C1), so CL part1–part3 are
  FC parts i–iii (D2, D9).
- [ ] A0 (optional, needs the 1999 booklet or the 1975 paper): the page's three sentences are the problem as Erdős,
  Galvin and Hajnal posed it, or the differences are as the claimant's paper describes (A2).

A reviewer who signs C1, A1–A3 and B1 has closed the semantic question for this problem. C1 is the line most likely to
need a set theorist's judgement, and the quickest to answer.
