
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
%token INDUCTION
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
|TYPE;type_name=IDENT;EQUAL;vertical=list(vert)
      {TypeDeclaration(type_name,vertical)}  //this part is for "type name_of_type = (type body)"
|LET; REC; function_name=IDENT; args=list(input);COLON;output_type=IDENT;EQUAL;m=match_statement
      {RecDeclaration(function_name,args,output_type,m)}  //this part is for "let rec function_name (h:int) : int = (match body) "

input:
|nm=IDENT; COLON; t=IDENT {TypeVariable(nm,t)}
|LPAREN;arg=input;RPAREN {arg}

astrik: //this part is for type declaration part     e2=astrik   (e3 * e4) =astrik
|nm=IDENT {LastAstrik(nm)} 
|e1=astrik; ASTRIK; e2=astrik {AstrikType(e1,e2)} // string * (int * (int * string)) -> e1 * e2 -> e1 * (e3 * e4) -> e1 * (e3 * (e5 * e6)) -> IDENT * IDENT * IDENT * IDENT
|LPAREN;astr=astrik;RPAREN {astr}

constructor: //this part is for type declaration part
|e1=IDENT; OF ; t=astrik {NormalType(e1,t)} // example : Cons "of" (a*b)
|nm=IDENT {SimpleType(nm)} // example: Nil

element: 
|nm=constructor{Construct(nm)} // Nil      Cons of (int * string)
|e1=expression;ARROW;e2=expression {ArrowStatement(e1,e2)} //Cons (h:int, t:int) "->" append (append Cons(h,t))

vert:
|VERT;e1=element {Vertical(e1)}

match_statement:
|MATCH;nm=IDENT;WITH;e1=list(vert) {Matching(nm,e1)} //taking care of "match string_name with" part

equality:
|LPAREN;e=equality;RPAREN {e}
|lhs=expression;EQUAL;rhs=expression {Equality(lhs,rhs)}

hint:
|HINT;AXIOM;ENDCOMMENT {Axiom} //(*hint: axiom*) part
|HINT;INDUCTION;nm=IDENT;ENDCOMMENT {Induction nm} //(*hint: induction x*) part

expression: //Cons (h:int, t:int)
|LPAREN;e=expression;RPAREN{e}   
|nm=IDENT{Identifier nm}
|e1=expression;COLON;e2=expression {Colon(e1,e2)} //in case of a:b 
|e1=expression;COMMA;e2=expression {Comma(e1,e2)} //in case of a,b
|e1=expression;nm=IDENT{Express(e1,nm)} //when something like cf x happens
|e1=expression;LPAREN;e2=expression;RPAREN{Application(e1,e2)} //when something like cf (x) happens

//Cons (h:int, t:int) -> expression ( expression ) -> expression ( expression1; COMMA; expression2) 
//->expression ((expression1;COLON;expression2);COMMA;(expression3;COLON;expression4)) -> Cons ((h:int),(t:int))






