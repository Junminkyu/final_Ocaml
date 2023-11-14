(* type statement = 
 | LetProve
 | LetRec
 | Type  *)
type expression =
| Axiom of string
| Prove of string
| Let of string
| Identifier of string
| Application of expression * expression
| TypeChecker of expression * expression
| Equal of expression * expression
| Int of string 
| List of string

(*| Match of *)
(*  | Application of (expression, expression list) 
  | Indentifier of string *)
