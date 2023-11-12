
%{
  open Ast
%}

%token <string> IDENT
%token COLON
%token <string> TYPE
%token LPAREN
%token RPAREN


%token EOF
%start main
%type <expression list> main
%%

main:
| e = expressions ; EOF { e }

expressions:
| e = expression ; es = expressions ;  { e::es }
| e = expression  { [e] }

expression:
| LPAREN ; e = expression ; RPAREN { e }
| nm = IDENT { Identifier nm }
| e1 = expression; nm = IDENT 
      { Application (e1, Identifier nm) }
| e1 = expression; LPAREN; e2 = expression; RPAREN
      { Application (e1, e2) }
| LPAREN; id = IDENT; COLON; ty = TYPE; RPAREN {TypedExpression (id, ty)}

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


