(* type statement = 
 | LetProve of expression * expression
 | LetRec of expression * expression *)
 type identifier = string

 type typedVar = 
 |TypeVariable of (string * string)

 type astrik = 
 |AstrikType of astrik * astrik
 |LastAstrik of string
 
 type constructor = 
 |NormalType of string * astrik
 |SimpleType of string
 

 type hint=
 |Axiom
 |Induction of string

 

 type expression =
 |Application of expression * expression
 |Comma of expression * expression
 |Colon of expression * expression
 |Identifier of string
 |Express of expression * string

 type arrowConstructor = 
 |Term of string
 |Expression of expression

 type element=
 |Construct of constructor
 |ArrowStatement of arrowConstructor * arrowConstructor
 
 type vert=
 |Vertical of element 


 type equality = 
 |Equality of (expression * expression)

 type match_statement=
 |Matching of (string * vert list)

 type declaration = 
 |ProofDeclaration of (string * typedVar list * equality * hint option)
 |TypeDeclaration of (string * vert list)
 |RecDeclaration of (string* typedVar list * string * match_statement)


 
 
 
 
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
 