include Ast
module Parser = Parser
module Lexer = Lexer
(*Incldued Ast because it does this file does not see the type Ast, its only called
   expression to parse the expressions it recieves*)

let rec string_of_expression ( e : expression ) 
= match e with
| Identifier nm -> nm
| Application (e1,e2) -> (string_of_expression e1)^" ("^
   (string_of_expression e2)^")"
| Express (e1,e2)->string_of_expression e1^" "^e2
| Comma (a,b) -> "("^string_of_expression a^" , "^string_of_expression b^")"
| Colon (a,b) -> string_of_expression a^" : "^string_of_expression b
  
let string_of_equality (e:equality)
= match e with
|Equality(a,b)->string_of_expression(a)^" = "^string_of_expression(b)


let string_of_hint (e:hint option)
= match e with
|None->""
|Some Axiom ->"(*hint: axiom*)"
|Some Induction x->"(*hint: induction "^x^"*)"

let rec string_of_astrik (e:astrik)
= match e with
|AstrikType (a,b)->string_of_astrik a^ " * "^string_of_astrik b
|LastAstrik a->a


let string_of_constructor (e:constructor)
= match e with
|NormalType(a,b)->a^" of ("^(string_of_astrik b)^") "
|SimpleType a ->a^" "

let string_of_arrowConstructor(e:arrowConstructor)
 = match e with
|Term nm->nm
|Expression nm->string_of_expression nm

let string_of_element (e:element)
 = match e with
| ArrowStatement(a,b)->string_of_arrowConstructor a^" -> "^string_of_arrowConstructor b
|Construct a ->string_of_constructor a
 
let rec string_of_vertical (e:vert list)
 = match e with 
|[]->""
|Vertical(a)::tl->"\n| "^string_of_element a^string_of_vertical tl
  
let rec string_of_typedVar (e:typedVar list)
= match e with
|[]->""
|TypeVariable (a,b)::tl-> "("^a^" : "^b^") "^string_of_typedVar(tl)

let string_of_match_statement (e:match_statement)
= match e with
|Matching (a,b) ->"match "^a^" with "^string_of_vertical b
  
let string_of_declaration (e:declaration)
= match e with
|ProofDeclaration (e1,e2,e3,e4) -> "let (*prove*) "^e1^" "^string_of_typedVar(e2)^"= \n"^string_of_equality(e3)^"\n"^string_of_hint(e4)^"\n"
|TypeDeclaration(e1,e2)->"type "^e1^" = "^string_of_vertical(e2)^"\n"
|RecDeclaration(e1,e2,e3,e4)->"let rec "^e1^" "^string_of_typedVar(e2)^" : "^e3^"= \n"^string_of_match_statement(e4)^"\n"





  
