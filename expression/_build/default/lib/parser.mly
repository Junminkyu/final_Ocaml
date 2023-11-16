
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
%start main
%type <declaration list> main
%%

main:
| list(declaration) ; EOF { $1 }

declaration:
|LET; PROVE; function_name=IDENT; arg=list(input);EQUAL;eq=equality;hint=option(hint) 
      {ProofDeclaration(function_name,arg,eq,hint)}
|TYPE;type_name=IDENT;EQUAL;vertical=vert
      {TypeDeclaration(type_name,vertical)}

input:
|nm=IDENT; COLON; t=IDENT {TypeVariable(nm,t)}
|LPAREN;arg=input;RPAREN {arg}

astrik:
|nm=IDENT {LastAstrik(nm)}
|e1=astrik; ASTRIK; e2=astrik {AstrikType(e1,e2)}
|LPAREN;astr=astrik;RPAREN {astr}

constructor:
|e1=IDENT; OF ; t=astrik {NormalType(e1,t)}
|nm=IDENT {SimpleType(nm)}

vert:
|nm=constructor{Construct(nm)}
|e1=vert;VERT;e2=vert {Vertical(e1,e2)}


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

