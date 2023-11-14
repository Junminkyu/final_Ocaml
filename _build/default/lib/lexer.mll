{
 open Parser
 exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"

rule token = parse
 | [' ' '\t'] { token lexbuf }
 | newline { Lexing.new_line lexbuf; token lexbuf }
 | ['a'-'z' 'A'-'Z' '0'-'9' '_' ',' '.' '<' '>' '-' '\'']+ as word { IDENT(word) }
 |"let" {LET}
 |"int" {INT}
 |"list"{LIST}
 |"(*prove*)" {PROVE}
 |"(*hint: axiom *)" {AXIOM}
 |"(*" {comment lexbuf} 
 |'=' {EQUAL}
 |':' {COLON}
 |"("{LPAREN}
 |")"{RPAREN}
 | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
 | eof { EOF }
 
 and comment = parse
 |"*)" {token lexbuf}
 | [' ' '\t'] { comment lexbuf }
 | _ {comment lexbuf}
 |newline { Lexing.new_line lexbuf; comment lexbuf }
 |eof { raise (SyntaxError "Unclosed comment") }