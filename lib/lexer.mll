{
 open Parser
 exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"

rule token = parse
 | [' ' '\t'] { token lexbuf }
 | newline { Lexing.new_line lexbuf; token lexbuf }
 | ['a'-'z' 'A'-'Z' '0'-'9' '_' ':' ',' '=' '\'']+ as word { IDENT(word) }
 |"(*prove*)" as word{IDENT(word)}
 |"(*hint: axiom *)" as word{IDENT(word)}
 |"(*" {comment lexbuf} 
 | '(' { LPAREN}
 | ')' { RPAREN}
 | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
 | eof { EOF }
 and comment = parse
 |"*)" {token lexbuf}
 | _ {comment lexbuf}
 |newline { Lexing.new_line lexbuf; comment lexbuf }
 |eof { raise (SyntaxError "Unclosed comment") }