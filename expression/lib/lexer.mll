{
 open Parser
 exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"

rule token = parse
 | [' ' '\t'] { token lexbuf }
 | newline { Lexing.new_line lexbuf; token lexbuf }
 |"let" {LET}
 |"(*prove*)" {PROVE}
 |'=' {EQUAL}
 |"("{LPAREN}
 |")"{RPAREN}
 |"|"{VERT}
 |"->"{ARROW}
 |"*"{ASTRIK}
 |"type" {TYPE}
 |"of" {OF}
 |"match "{MATCH}
 |"(*hint:" {HINT}
 |"axiom" {AXIOM}
 |"with" {WITH}
 |"(*" {comment 0 lexbuf} 
 |"*)" {ENDCOMMENT}
 |':' {COLON}
 |['a'-'z' 'A'-'Z' '0'-'9' '_' ',' '.' '<' '>' '-' '\'']+ as word { IDENT(word) }
 | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
 | eof { EOF }
 
 and comment level = parse
| "*)" { if level = 0 then token lexbuf
else comment (level - 1) lexbuf }
| "(*" { comment (level + 1) lexbuf }
| newline { Lexing.new_line lexbuf; comment level lexbuf }
| _ { comment level lexbuf }