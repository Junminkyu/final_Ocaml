
(* The type of tokens. *)

type token = 
  | TYPE
  | RPAREN
  | REC
  | PROVE
  | NEXT
  | LPAREN
  | LIST
  | LET
  | INT
  | IDENT of (string)
  | EQUAL
  | EOF
  | COLON
  | AXIOM

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expression list)
