
(* The type of tokens. *)

type token = 
  | RPAREN
  | PROVE of (string)
  | LPAREN
  | IDENT of (string)
  | EOF
  | COLON
  | AXIOM of (string)

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expression list)
