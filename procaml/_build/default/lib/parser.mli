
(* The type of tokens. *)

type token = 
  | RPAREN
  | PROVE
  | LPAREN
  | LET
  | IDENT of (string)
  | HINT
  | EQUAL
  | EOF
  | ENDCOMMENT
  | COMMA
  | COLON
  | AXIOM

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.declaration list)

val expression_eof: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expression)
