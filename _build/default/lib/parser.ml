
module MenhirBasics = struct
  
  exception Error
  
  let _eRR : exn =
    Error
  
  type token = 
    | SEP
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
  | MenhirState15
  | MenhirState13
  | MenhirState9
  | MenhirState6
  | MenhirState1
  | MenhirState0

# 2 "lib/parser.mly"
  
  open Ast

# 52 "lib/parser.ml"

let rec _menhir_run6 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
    | INT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | LIST ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | LPAREN ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState6

and _menhir_run8 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_menhir_stack, _menhir_s, (e1 : (Ast.expression))) = _menhir_stack in
    let _v : (Ast.expression) = 
# 37 "lib/parser.mly"
      (Application(e1, Prove "(*prove*)"))
# 80 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run9 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState9 _v
    | INT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | LIST ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | LPAREN ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState9

and _menhir_run12 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> (
# 6 "lib/parser.mly"
       (string)
# 105 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (nm : (
# 6 "lib/parser.mly"
       (string)
# 113 "lib/parser.ml"
    )) = _v in
    let (_menhir_stack, _menhir_s, (e1 : (Ast.expression))) = _menhir_stack in
    let _v : (Ast.expression) = 
# 39 "lib/parser.mly"
      ( Application (e1, Identifier nm) )
# 119 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run13 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
    | INT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | LIST ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | LPAREN ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState13

and _menhir_run15 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState15 _v
    | INT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState15
    | LIST ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState15
    | LPAREN ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState15
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState15

and _menhir_run17 : _menhir_env -> 'ttv_tail * _menhir_state * (Ast.expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_menhir_stack, _menhir_s, (e1 : (Ast.expression))) = _menhir_stack in
    let _v : (Ast.expression) = 
# 35 "lib/parser.mly"
      (Application(e1, Axiom "(*hint: axiom*)"))
# 167 "lib/parser.ml"
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
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (e : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression) = 
# 32 "lib/parser.mly"
                                   ( e )
# 200 "lib/parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | SEP ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState6 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | SEP ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack)
        | EOF | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.expression))), _, (e2 : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression) = 
# 42 "lib/parser.mly"
      ( SEP (e1, e2) )
# 236 "lib/parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState9 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.expression))), _, (e2 : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression) = 
# 46 "lib/parser.mly"
      ( Application (e1, e2) )
# 270 "lib/parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | SEP ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | SEP ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack)
        | EOF | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.expression))), _, (e2 : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression) = 
# 50 "lib/parser.mly"
      (Equal(e1,e2))
# 306 "lib/parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState15 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | SEP ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack)
        | EOF | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.expression))), _, (tp : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression) = 
# 48 "lib/parser.mly"
      ( TypeChecker(e1,tp))
# 340 "lib/parser.ml"
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
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack)
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (e : (Ast.expression))) = _menhir_stack in
            let _v : (Ast.expression list) = 
# 25 "lib/parser.mly"
                     ( [e] )
# 365 "lib/parser.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (Ast.expression list)) = _v in
            Obj.magic _1
        | EQUAL ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _v ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _v
        | LPAREN ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack)
        | PROVE ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack)
        | SEP ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState15 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState9 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState6 ->
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
# 52 "lib/parser.mly"
     (List "list")
# 441 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run3 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Ast.expression) = 
# 51 "lib/parser.mly"
     (Int "int")
# 452 "lib/parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run4 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 6 "lib/parser.mly"
       (string)
# 459 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (nm : (
# 6 "lib/parser.mly"
       (string)
# 467 "lib/parser.ml"
    )) = _v in
    let _v : (Ast.expression) = 
# 33 "lib/parser.mly"
             ( Identifier nm )
# 472 "lib/parser.ml"
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
  

# 516 "lib/parser.ml"
