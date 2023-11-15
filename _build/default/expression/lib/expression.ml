include Ast
module Parser = Parser
module Lexer = Lexer
(*Incldued Ast because it does this file does not see the type Ast, its only called
   expression to parse the expressions it recieves*)


   



   let string_of_typedVar (tv : typedVar) =
    match tv with
    | TypeVariable (name, type_) -> "(" ^ name ^ " : " ^ type_ ^ ")"
  
  let rec string_of_expression (e : expression) =
    match e with
    | Application (e1, e2) -> "(" ^ string_of_expression e1 ^ " " ^ string_of_expression e2 ^ ")"
    | Identifier name -> name
   
  
  let string_of_hint (h : hint option) =
    match h with
    | None -> ""
    | Some Axiom -> "(* hint: axiom *)"
  
  let string_of_equality (eq : equality) =
    match eq with
    | Equality (e1, e2) -> string_of_expression e1 ^ " = " ^ string_of_expression e2
  
  let string_of_declaration (d : declaration) =
    match d with
    | ProofDeclaration (name, args, eq, hint) ->
      "let (* prove *) " ^ name ^ " " ^
      String.concat " " (List.map string_of_typedVar args) ^ " = " ^
      string_of_equality eq ^ "\n" ^ string_of_hint hint
  
  let string_of_top_level_item (item : decision_level) =
    match item with
    | DecisionLevDeclaration d -> string_of_declaration d
    | DecisionLevExpression e -> string_of_expression e


(* and string_of_expression_with_parens e
  = match e with 
  | Identifier nm -> nm
  | Let nm->nm
  | Axiom nm -> "\n"^nm^"\n"
  | Prove nm -> nm 
  | Application _ ->  "(" ^ string_of_expression e ^ ")" 
  | TypeChecker(e1,e2)->"("^(string_of_expression e1)^" : "^(type_of_parameter_expression e2)^")"
  | Equal(e1,e2,e3)->(string_of_expression e1)^" = ("^(string_of_expression e2)^" "^(string_of_expression e3)^")" *)



  
