
module MenhirBasics = struct
  
  exception Error
  
  let _eRR : exn =
    Error
  
  type token = 
    | TYPE
    | RPAREN
    | PROVE
    | NEXT
    | LPAREN
    | LIST
    | LET
    | INT
    | IDENT of (
# 6 "lib/parser.mly"
       (string)
# 22 "lib/parser.ml"
  )
    | EQUAL
    | EOF
    | COLON
    | AXIOM
  
end

include MenhirBasics

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState14
  | MenhirState12
  | MenhirState8
  | MenhirState1
  | MenhirState0

# 2 "lib/parser.mly"
  
  open Ast

# 51 "lib/parser.ml"

let rec _menhir_run7 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_menhir_stack, _menhir_s, (e1 : (Ast.expression))) = _menhir_stack in
    let _v : (Ast.expression) = 
# 36 "lib/parser.mly"
      (Application(e1, Prove "(*prove*)"))
# 61 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run8 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | INT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | LIST ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | LPAREN ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState8

and _menhir_run11 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> (
# 6 "lib/parser.mly"
       (string)
# 86 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (nm : (
# 6 "lib/parser.mly"
       (string)
# 94 "lib/parser.ml"
    )) = _v in
    let (_menhir_stack, _menhir_s, (e1 : (Ast.expression))) = _menhir_stack in
    let _v : (Ast.expression) = 
# 38 "lib/parser.mly"
      ( Application (e1, Identifier nm) )
# 100 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run12 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | INT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | LIST ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | LPAREN ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState12

and _menhir_run14 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
    | INT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | LIST ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | LPAREN ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState14

and _menhir_run16 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_menhir_stack, _menhir_s, (e1 : (Ast.expression))) = _menhir_stack in
    let _v : (Ast.expression) = 
# 34 "lib/parser.mly"
      (Application(e1, Axiom "(*hint: axiom*)"))
# 148 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack)
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (e : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression) = 
# 31 "lib/parser.mly"
                                   ( e )
# 181 "lib/parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState8 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack)
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.expression))), _, (e2 : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression) = 
# 40 "lib/parser.mly"
      ( Application (e1, e2) )
# 215 "lib/parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack)
        | EOF | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.expression))), _, (e2 : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression) = 
# 44 "lib/parser.mly"
      (Equal(e1,e2))
# 247 "lib/parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState14 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack)
        | EOF | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.expression))), _, (tp : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression) = 
# 42 "lib/parser.mly"
      ( TypeChecker(e1,tp))
# 279 "lib/parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | AXIOM ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack)
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (e : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression list) = 
# 24 "lib/parser.mly"
                     ( [e] )
# 304 "lib/parser.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (Ast.expression list)) = _v in
            Obj.magic _1
        | EQUAL ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState14 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState8 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | INT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | LIST ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | LPAREN ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState1

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Ast.expression) = 
# 46 "lib/parser.mly"
     (List "list")
# 374 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run3 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Ast.expression) = 
# 45 "lib/parser.mly"
     (Int "int")
# 385 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run4 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 6 "lib/parser.mly"
       (string)
# 392 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (nm : (
# 6 "lib/parser.mly"
       (string)
# 400 "lib/parser.ml"
    )) = _v in
    let _v : (Ast.expression) = 
# 32 "lib/parser.mly"
             ( Identifier nm )
# 405 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expression list) =
  fun lexer lexbuf ->
    let _menhir_env = {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = Obj.magic ();
      _menhir_error = false;
    } in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | INT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LIST ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LPAREN ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0)

# 269 "<standard.mly>"
  

# 449 "lib/parser.ml"
