import YatimaStdLib
import Megaparsec.Pos

open Megaparsec.Pos

namespace Megaparsec.Errors

universe u
universe v
variable (β : Type u)
variable {γ : Type u} [Ord γ] [BEq γ]

/-- Error data types, and ways to bundle those together. -/

inductive ErrorItem where
| tokens (t : NEList β)
| label (l : NEList Char)
| eof

--                    TODO: make this a set
--                             |
--                             v
abbrev Hints (⅌ : Type u) := List (List (ErrorItem ⅌))

instance ord2beq_ei : BEq (ErrorItem γ) where
  beq (x y : ErrorItem γ) :=
    match x, y with
    | .tokens nelᵤ, .tokens nelᵥ => NEList.beq nelᵤ nelᵥ
    | .label nelᵤ, .label nelᵥ => NEList.beq nelᵤ nelᵥ
    | .eof, .eof => true
    | _, _ => false

def errorItemMax (e₁ : ErrorItem γ) (e₂ : ErrorItem γ) : ErrorItem γ :=
  match BEq.beq e₁ e₂ with
    | true => e₂
    | false => e₁

inductive ErrorFancy (E : Type u) where
| fail (msg : String)
| indent (ord : Ordering) (fromPos : Pos) (uptoPos : Pos)
| custom (e : E)

end Megaparsec.Errors
