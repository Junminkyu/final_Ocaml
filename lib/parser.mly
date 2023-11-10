
%{
  open Ast
%}

%token <string> IDENT
%token COLON
%token LPAREN
%token RPAREN


%token EOF
%start main
%type <expression list> main
%%

main:
| e = expression ; EOF { [e] }

expression:
| LPAREN ; e = expression ; RPAREN { e }
| nm = IDENT { Identifier nm }
| e1 = expression; e2 = expression { Application (e1, e2) }




