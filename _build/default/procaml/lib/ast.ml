type typevariant = Variant of (string * string list)
type typedVariable = TypedVariable of (string * string)

type expression
 = Application of (expression * expression)
 | Identifier of string
type equality
 = Equality of (expression * expression)
type hint
 = Axiom

type declaration
  = ProofDeclaration of (string * typedVariable list * equality * hint option)
