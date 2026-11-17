-- Worked examples for the reading guide (cycle 1) of Erdős Problem #1177.
--
-- NOT YET RUN. These commands were written on 2026-11-17 from source read at pinned commits; nobody has run them
-- through Lean. No output is claimed for any line. Whoever runs them should commit the transcript as trace.txt
-- next to this file, with the toolchain and commit they used.
--
-- The file has two halves, because the two formalisations sit on different Mathlib revisions and cannot be imported
-- together:
--   Part 1 runs inside the claimant's development (ericlisg/erdos-593-1177-lean at 5dcb6e49, Lean v4.28.0,
--          Mathlib 8f9d9cff), e.g. saved as RequestProject/DebriefTrace.lean and run with `lake env lean`.
--   Part 2 runs inside google-deepmind/formal-conjectures at e028240a (Lean v4.33.1, Mathlib 0df444a3).
-- Split the file at the marked line before running.

import RequestProject.PublicationCertificate

/-! ## Part 1: the claimant's statements and definitions -/

open Cardinal

namespace Erdos593

-- 1. The three statements, as the development states them.
#print FullResolution
#check @full_resolution_unconditional
#check @problem_1177_part1_aleph_one
#check @problem_1177_part2_unconditional
#check @problem_1177_part3_unconditional
#print axioms full_resolution_unconditional  -- the claimant reports propext, Classical.choice, Quot.sound

-- 2. The definitions behind them (trace Part C).
#print FTS
#print FTS.FGnonempty
#print FTS.Embeds
#print Hypergraph
#print Hypergraph.IsTripleSystem
#print Hypergraph.HasChromatic
#print Hypergraph.ColorableBy
#print Hypergraph.ProperColoring
#print FTS.LinearlyObligatory
#check @e5_HK_loose7

-- 3. ℵ₁ is the successor of ℵ₀ (discrepancy D9).
example : Order.succ (ℵ₀ : Cardinal.{0}) = Cardinal.aleph 1 := Cardinal.succ_aleph0

-- 4. The colour type for θ colours has exactly θ elements.
example (θ : Cardinal.{0}) : #θ.out = θ := Cardinal.mk_out θ

-- 5. An exact-ℵ₁-chromatic system is uncountably chromatic (not colourable with ℵ₀ colours).
example {W : Type} (K : Hypergraph W) (h : K.HasChromatic (Cardinal.aleph 1)) : K.UncountablyChromatic :=
  h.2 ℵ₀ Cardinal.aleph0_lt_aleph_one

-- 6. Part 2 in the claimant's ∃-form is the negation of assertion 2 in ∀-form, with both hypotheses kept (D4).
example :
    (∃ (G H : FTS), G.FGnonempty (Cardinal.aleph 1 : Cardinal.{0}) ∧ H.FGnonempty (Cardinal.aleph 1) ∧
      ¬ ∃ (W : Type) (K : Hypergraph W), K.IsTripleSystem ∧ K.HasChromatic (Cardinal.aleph 1) ∧
        ¬ G.Embeds K ∧ ¬ H.Embeds K) ↔
    ¬ ∀ (G H : FTS), G.FGnonempty (Cardinal.aleph 1 : Cardinal.{0}) → H.FGnonempty (Cardinal.aleph 1) →
      ∃ (W : Type) (K : Hypergraph W), K.IsTripleSystem ∧ K.HasChromatic (Cardinal.aleph 1) ∧
        ¬ G.Embeds K ∧ ¬ H.Embeds K := by
  constructor
  · rintro ⟨G, H, hG, hH, hno⟩ hall
    exact hno (hall G H hG hH)
  · intro h
    by_contra hc
    apply h
    intro G H hG hH
    by_contra hK
    exact hc ⟨G, H, hG, hH, hK⟩

-- 7. The paper's G for part 2: two triples sharing a pair. It is a finite triple system and it is not linear.
def T0 : FTS where
  V := Fin 4
  edges := {{0, 1, 2}, {0, 1, 3}}
  card3 := by decide

example : ¬ T0.Linear := by
  unfold FTS.Linear
  decide

-- 8. The uncountable (1999-booklet) form of the "no" (discrepancy D1), stated so a reader can see what is NOT among
--    the headline theorems. It is left as a statement with no proof here; nothing in this record claims it.
def Part2Uncountable : Prop :=
  ∃ (G H : FTS),
    (∃ (W : Type) (K : Hypergraph W), K.IsTripleSystem ∧ K.UncountablyChromatic ∧ ¬ G.Embeds K) ∧
    (∃ (W : Type) (K : Hypergraph W), K.IsTripleSystem ∧ K.UncountablyChromatic ∧ ¬ H.Embeds K) ∧
    ¬ ∃ (W : Type) (K : Hypergraph W), K.IsTripleSystem ∧ K.UncountablyChromatic ∧ ¬ G.Embeds K ∧ ¬ H.Embeds K
#print Part2Uncountable

end Erdos593

/-! ## ---------------- split here ---------------- -/
/-! ## Part 2: the formal-conjectures statements and definitions -/

-- import FormalConjectures.ErdosProblems.«1177»
-- open Cardinal
--
-- -- 9. The three statements. Their proofs are `sorry` in that repository: it states problems, it does not solve them.
-- #check @Erdos1177.erdos_1177.parts.i
-- #check @Erdos1177.erdos_1177.parts.ii
-- #check @Erdos1177.erdos_1177.parts.iii
-- #print axioms Erdos1177.erdos_1177.parts.ii  -- expected to list sorryAx
--
-- -- 10. The definitions behind them.
-- #print UniformHypergraph
-- #print UniformHypergraph.chromaticCardinal
-- #print UniformHypergraph.Appears
-- #print UniformHypergraph.HasAvoidingChromaticCardinal
-- #print Hypergraph.IsUniform
-- #print Hypergraph.IsProperColoring
-- #print Hypergraph.image
--
-- -- 11. The sInf convention: an empty set of cardinals has infimum 0 (D5). It never applies to a 3-uniform
-- --     hypergraph, since the identity map is a proper colouring.
-- example : sInf (∅ : Set Cardinal.{0}) = 0 := Cardinal.sInf_empty
-- example {V : Type} (H : UniformHypergraph V 3) : H.chromaticCardinal ≤ #V :=
--   H.chromaticCardinal_le_mk (by norm_num)
--
-- -- 12. Universe: in parts.iii the cardinals κ, μ live in Cardinal.{0}, fixed by W : Type (D6).
-- set_option pp.universes true in
-- #check @Erdos1177.erdos_1177.parts.iii
