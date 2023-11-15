include Expression
let parse (s : string) : Ast.expression list =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.main Lexer.token lexbuf in
     ast