module Parser = Parser
module Lexer = Lexer

let rec string_of_expression ( e : Ast.expression ) =
  match e with 
  | Identifier nm -> nm
  | Application (a,b) -> string_of_expression a ^" "^string_of_expression b
