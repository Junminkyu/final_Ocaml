include Ast
module Parser = Parser
module Lexer = Lexer
(*Incldued Ast because it does this file does not see the type Ast, its only called
   expression to parse the expressions it recieves*)


   



  let rec string_of_expression ( e : expression ) 
  = match e with
  | Identifier nm -> nm
  | Application (e1,e2) -> "("^(string_of_expression e1)^" "^
    (string_of_expression e2)^")"
  
  let string_of_equality (e:equality)
  = match e with
  |Equality(a,b)->string_of_expression(a)^" = "^string_of_expression(b)

  let string_of_hint (e:hint option)
  = match e with
  |None->""
  |Some Axiom ->"(*hint: axiom*)"

  let rec string_typedVar (e:typedVar list)
  = match e with
  |[]->""
  |TypeVariable (a,b)::tl-> "("^a^":"^b^") "^string_typedVar(tl)
  
  let string_of_declaration (e:declaration)
  = match e with
  |ProofDeclaration (e1,e2,e3,e4) -> "let (*prove*) "^e1^" "^string_typedVar(e2)^" = "^string_of_equality(e3)^"\n"^string_of_hint(e4)


  let string_of_top_level_item (item: decision_level) =
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



  
