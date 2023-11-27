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
%token ENDCOMMENT /* there is no startcomment, as it's called "hint", and proper comments are ignored by the lexer */
%token AXIOM
%start main
%type <declaration list> main
%start expression_eof
%type <expression> expression_eof
%%

main:
| list(declaration) EOF { $1 }
expression_eof:
| e = expression; EOF {e}
declaration:
| LET ; PROVE ; lemma_name=IDENT ; args = list(argument) ; EQUAL ; eq = equality ; hint=option(hint)
   { ProofDeclaration (lemma_name, args, eq, hint) }
argument:
| nm = IDENT; COLON; t = IDENT { TypedVariable (nm, t) }
| LPAREN ; arg = argument; RPAREN { arg }
equality:
| LPAREN ; e = equality ; RPAREN { e }
| lhs = expression ; EQUAL ; rhs = expression { Equality (lhs, rhs) }
hint:
| HINT ; AXIOM ; ENDCOMMENT { Axiom }
expression:
| LPAREN ; e = expression_with_commas ; RPAREN { e }
| lhs = expression ; arg = IDENT { Application (lhs, Identifier arg) }
| lhs = expression ; LPAREN ; arg = expression_with_commas ; RPAREN
   { Application (lhs, arg) }
| nm = IDENT { Identifier nm }

// these aren't in the gettingstarted.ml syntax,
// but here's a suggestion to deal with these anyways.
// We're using that "," is not a valid identifier
// We're using it as an identifier that stands for the function (fun x y -> (x, y))
// This also means we're representing (x,y,z) and ((x,y),z) as the same thing.
expression_with_commas:
| e = expression { e }
| e1 = expression_with_commas ; COMMA ; e2 = expression
  { Application (Application (Identifier ",", e1), e2)}