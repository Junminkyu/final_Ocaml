
(* The type of tokens. *)

type token = 
  | WITH
  | VERT
  | TYPE
  | RPAREN
  | PROVE
  | OF
  | MATCH
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
  | ASTRIK
  | ARROW

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.declaration list)
