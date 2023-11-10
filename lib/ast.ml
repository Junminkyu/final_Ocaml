
type expression =
 | Identifier of string
 | Application of expression * expression
(*| Match of *)
(*  | Application of (expression, expression list) 
  | Indentifier of string *)
