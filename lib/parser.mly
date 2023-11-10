
%{
  open Ast
%}
%token <string> IDENT
%token COLON
%token LPAREN
%token RPAREN

%token <string> WORD
%token EOF
%start main
%type <string list> main
%%
main:
| line EOF { $1 }
line:
| { [] }
| WORD line { $1 :: $2 }

