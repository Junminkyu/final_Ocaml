
type expression =
| Axiom of string
| Prove of string
| Identifier of string
| Application of expression * expression
(*| Match of *)
(*  | Application of (expression, expression list) 
  | Indentifier of string *)
