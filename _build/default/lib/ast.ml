(* type statement = 
 | LetProve of expression * expression
 | LetRec of expression * expression *)
type identifier = string

type typedVar = TypeVariable of (string * string)

type expression =
|Application of expression * expression
|Identifier of string

type hint=
|Axiom
|Induction

type equality = Equality of (expression * expression)

type declaration = Equality of (expression * expression)



(* 
| Axiom of string
| Prove of string
(* | Rec of string *)
| Let of string
| Identifier of string
| Application of expression * expression
| TypeChecker of expression * typeOfParameter
| Equal of expression * expression * expression
and typeOfParameter =
| Int of string 
| List of string *)

(*| Match of *)
(*  | Application of (expression, expression list) 
  | Indentifier of string *)
