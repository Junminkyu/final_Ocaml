
(* The type of tokens. *)

type token = 
  | TYPE of (string)
  | RPAREN
  | LPAREN
  | IDENT of (string)
  | EOF
  | COLON

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expression list)
