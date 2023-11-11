include Ast
module Parser = Parser
module Lexer = Lexer
(*Incldued Ast because it does this file does not see the type Ast, its only called
   expression to parse the expressions it recieves*)
let rec string_of_expression ( e : expression ) 
  = match e with 
  | Identifier nm -> nm
  | Application (e1,e2) ->  
    (string_of_expression e1) ^
    " " ^ (string_of_expression_with_parens e2) 
and string_of_expression_with_parens e
  = match e with 
  | Identifier nm -> nm
  | Application _ ->  "(" ^ string_of_expression e ^ ")"
  
