
type expression =
 | Identifier of string
 | Application of expression * expression
 | TypedExpression of string * string
(*| Match of *)
(*  | Application of (expression, expression list) 
  | Indentifier of string *)
