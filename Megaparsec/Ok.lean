import Megaparsec.Errors
import Megaparsec.ParserState

open Megaparsec.Errors
open Megaparsec.ParserState

namespace Megaparsec.Ok

def Ok (m : Type f → Type v) (β ℘ E γ : Type u) (ξ : Type f) :=
  (γ → State β ℘ E → Hints β → m ξ)

/-
`accHints hs c` adds hints to “OK” continuation that will add given
hints @hs@ to third argument of original continuation c
-/
def accHints (hs : Hints β)
             (f : Ok m β ℘ E γ ξ) : Ok m β ℘ E γ ξ :=
  fun x s hs₀ => f x s (hs ++ hs₀)
