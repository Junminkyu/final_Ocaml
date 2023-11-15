
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
%token ENDCOMMENT /*there is no startcomment, as it's called hint",and proper comments are ignored by the lexer */
%token AXIOM
// %token LET
// %token REC
// %token PROVE
// %token NEXT
// %token COLON
// %token LPAREN
// %token RPAREN
// %token AXIOM
// %token TYPE
// %token EQUAL
// %token EOF
// %token LIST
// %token INT
%start main
%type <expression list> main
%%

main:
| list(declaration) ; EOF { $1 }
// d=list(statement)
// statement:
// | TYPE: s = typedef; {s}
// | LET ; REC; letrec
// | LET ; PROVE ; letprove
declaration:
| LET; PROVE; lemma_name=IDENT; args=list(argument);EQUAL;eq=equality;hint=option(hint)
      {ProofDeclaration(lemma_name,args,eq,hint)}
argument:
|nm=IDENT; COLON; t=IDENT {TypedVariable(nm,t)}
|LPAREN;arg=argument;RPAREN {arg}
equality:
|LPAREN;e=equality;RPAREN {e}
|lhs=expression;EQUAL;rhs=expression{Equality(lhs,rhs)}
hint:
|HINT;AXIOM;ENDCOMMENT {Axiom}
expression:
|LPAREN;e=expression;RPAREN{e}
|nm=IDENT{identifier nm}
|e1=expression;nm=IDENT{Application(e1,Identifier nm)}
|e1=expression;LPAREN;e2=expression;RPAREN{Application(e1,e2)}
// | LPAREN ; e = expression ; RPAREN { e }
// | nm = IDENT { Identifier nm }
// | e1= expression; AXIOM //e1 (*hint: axiom*) situation
//       {Application(e1, Axiom "(*hint: axiom*)")}
// | e1=expression; PROVE  // e1 (*prove*) situation
//       {Application(e1, Prove "(*prove*)")}
// | e1=expression; nm =IDENT
//       { Application (e1, Identifier nm)}
// | e1 = expression; LPAREN; e2 = expression; RPAREN // e1 (e2) situation
//       { Application (e1, e2)}
// | e1=expression;COLON; tp=typeofparameter // e1 : e2 situation. for example (h:int)
//       { TypeChecker(e1,tp)}
// | e1=expression;EQUAL;e2=expression; nm=IDENT // e1 = e2 situation
//       {Equal(e1,e2,Identifier nm)}
// | e1=expression;EQUAL;e2=expression; LPAREN; e3=expression; RPAREN
//       {Equal(e1,e2,e3)}
typeofparameter:
|INT {Int "int"}
|LIST{List "list"}



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

