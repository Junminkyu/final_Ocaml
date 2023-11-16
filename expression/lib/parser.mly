
%{
  open Ast
%}

%token <string> IDENT
%token COLON
%token LPAREN
%token RPAREN
%token PROVE
%token LET
%token EQUAL
%token EOF
%token HINT 
%token COMMA
%token ENDCOMMENT
%token AXIOM
%token MATCH
%token ARROW
%token WITH
%token VERT
%token ASTRIK
%token TYPE
%token OF
%token REC
%start main
%type <declaration list> main
%%

main:
| list(declaration) ; EOF { $1 }

declaration:
|LET; PROVE; function_name=IDENT; arg=list(input);EQUAL;eq=equality;hint=option(hint) 
      {ProofDeclaration(function_name,arg,eq,hint)} //this part is for "let (*prove*) function_name (h:int) = (function body) (*hint: axiom*) "
|TYPE;type_name=IDENT;EQUAL;vertical=vert
      {TypeDeclaration(type_name,vertical)}  //this part is for "type name_of_type = (type body)"
|LET; REC; function_name=IDENT; args=list(input);COLON;output_type=IDENT;EQUAL;m=match_statement
      {RecDeclaration(function_name,args,output_type,m)}  //this part is for "let rec function_name (h:int) : int = (match body) "

input:
|nm=IDENT; COLON; t=IDENT {TypeVariable(nm,t)}
|LPAREN;arg=input;RPAREN {arg}


astrik: //this part is for type declaration part
|nm=IDENT {LastAstrik(nm)}
|e1=astrik; ASTRIK; e2=astrik {AstrikType(e1,e2)} //in case of (int * int * string )
|LPAREN;astr=astrik;RPAREN {astr}

constructor: //this part is for type declaration part
|e1=IDENT; OF ; t=astrik {NormalType(e1,t)} // example : Cons "of" ()
|nm=IDENT {SimpleType(nm)} // example: Nil


arrowConstructor: //not finished yet, this is for let rec declaration part
|nm=IDENT {Term(nm)}

vert: 
|nm=constructor{Construct(nm)}
|e1=arrowConstructor;ARROW;e2=arrowConstructor {ArrowStatement(e1,e2)} // in case of a->b
|e1=vert;VERT;e2=vert {Vertical(e1,e2)} // in case of a | b

match_statement:
|MATCH;nm=IDENT;WITH;e1=vert {Matching(nm,e1)} //taking care of "match string_name with" part


equality:
|LPAREN;e=equality;RPAREN {e}
|lhs=expression;EQUAL;rhs=expression {Equality(lhs,rhs)}

hint:
|HINT;AXIOM;ENDCOMMENT {Axiom}

expression:
|LPAREN;e=expression;RPAREN{e}
|nm=IDENT{Identifier nm}
|e1=expression;nm=IDENT{Application(e1,Identifier nm)}
|e1=expression;LPAREN;e2=expression;RPAREN{Application(e1,e2)}




(*IDENT WORKS LIKE THIS, IDENT works in the lexer and captures
  things such as Letter, Numbers and Underscores, Backslashes
  it then wraps all of those things like this, IDENT(word) 
  and so its like a tuple with a cover on it called IDENT
  if we know something is covered with IDENT we have an inkling of
  what it carries, stated above^ (could also be other things later on)
  IN expression.ml it reads these tokens and types from the AST and begins to 
  decode them based on the tokens and "wrappings" they have 
  
  Here nm is a string and turn turn a string into a type expression we can put Identifier
  infront of it, which is one of the identifiers*)

