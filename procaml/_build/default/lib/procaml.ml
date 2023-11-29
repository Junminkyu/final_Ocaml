include Ast
module Parser = Parser
module Lexer = Lexer

let parse (s : string) : declaration list =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.main Lexer.token lexbuf in
     ast

let rec string_of_expression (e : expression) : string =
  match e with
  | Application (e, arg) ->
    (string_of_expression e) ^ " (" ^ string_of_expression arg ^ ")"
  | Identifier name -> name

let string_of_hint (h : hint option) : string =
  match h with
  | Some Axiom -> "\n(*hint: axiom *)"
  | None -> ""
let string_of_equality (e : equality) : string =
  match e with
  | Equality (e1, e2) -> "(" ^ (string_of_expression e1) ^ " = " ^ (string_of_expression e2) ^ ")"
let string_of_typedvariable (TypedVariable (name, type_name) : typedVariable) : string =
  "(" ^ name ^ " : " ^ type_name ^ ")"
let string_of_declaration (d : declaration) : string =
  match d with
  | ProofDeclaration (name, args, equality, hint) ->
    let arg_strings = List.map string_of_typedvariable args in
    "let (*prove*) " ^ name ^ " " ^ (String.concat " " arg_strings) ^ " = "
     ^ string_of_equality equality ^ string_of_hint hint

(* ------------------------------------------------------------------------------------------------- *)


let parse_expression (s : string) : expression =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.expression_eof Lexer.token lexbuf in
      ast
     
module Substitution = struct
  module MM = Map.Make(String)
    type t = expression MM.t
    let empty = MM.empty
    let singleton = MM.singleton
       
    (* exception Match_expr_exception *)
    let merge map1 map2=
      let helper _ m1 m2 =
        match m1, m2 with
        |None, None -> None
        |Some m, None -> Some m
        |None, Some m->Some m
        |Some m1, Some m2 when m1=m2 -> Some m1 
        |Some _, Some _ -> None
      in MM.merge helper map1 map2
     
    let find=MM.find
    end

    
    let rec match_expression variables pattern expression =
      match pattern with
        | Identifier x -> if List.mem x variables then Some (Substitution.singleton x expression)
                          else (if pattern = expression then Some Substitution.empty else None)
        | Application (p1, p2) -> 
          (match expression with
              | Application (e1, e2) ->
                      (* We recursively match the sub-expressions.
                          This part is much easier to write if e2 is an expression (and it is for this particular ast),
                          because it's so symmetrical *)
                      (match match_expression variables p1 e1, match_expression variables p2 e2 with
                      | Some s1, Some s2 -> Some(Substitution.merge s2 s1)
                      | _ -> None)
                  | _ -> None)


    let rec substitute (variables:string list) (map: Substitution.t) (exp:expression) : expression = 
      match exp with
      |Identifier nm -> (try
                          Substitution.find nm map
                        with
                        | Not_found -> exp)
      |Application(e1,e2)->Application(substitute(variables)(map)(e1),substitute(variables)(map)(e2))

      (* let rec attempt_rewrite variables lhs rhs expression =
        match match_expression variables lhs expression with
        | Some x -> Some (substitute variables x rhs)
        | None -> (
            match expression with
            | Application (e1, e2) ->
                (match (attempt_rewrite variables lhs rhs e1), (attempt_rewrite variables lhs rhs e2) with
                |None,None->None
                |Some r, None -> Some (Application (r, e2))
                | None, Some r -> Some (Application(e1,r))
                | Some e1', Some e2' -> Some (Application (e1', e2'))
                )
            | _ -> None
          ) *)

  let rec attempt_rewrite vars lhs rhs e = 
    match (match_expression vars lhs e) with
          | Some subst -> Some (substitute vars subst rhs)
          | None -> 
              (
                match e with
                | Application (e1, e2) -> 
                  (
                    match (attempt_rewrite vars lhs rhs e1), (attempt_rewrite vars lhs rhs e2) with
                    | None, None -> None
                    | Some r, None -> Some (Application (r, e2))
                    | None, Some r -> Some (Application (e1, r))
                    | Some r1, Some r2 -> Some (Application (r1, r2))
                  )
                | _ -> None
              )
    
  let rec perform_step rules expression = 
    match rules with
    |(nm,variables,lhs,rhs):: rest -> (match attempt_rewrite variables lhs rhs expression with
                                            |Some e-> Some (nm,e)
                                            |None->perform_step rest expression)
    |_->None  

    let rec perform_steps rules expression = match perform_step rules expression with
    |None ->[]
    |Some (nm,e)-> (nm,e):: perform_steps rules e

  
    
    let rec get_string (vars:typedVariable list): string list=
      match vars with
      |[]->[]
      |TypedVariable(a,_)::tl-> a::get_string tl

      let rec prove rules lhs rhs
      = string_of_expression lhs:: (match perform_steps rules lhs with
                                    |(nm,e):: _ -> (" ={ "^nm^" }")::prove rules e rhs
                                    |[]->if lhs=rhs then [] else "= {???}"::[string_of_expression rhs])
    
    
    let rec prover rules declarations =
      match declarations with
      | ProofDeclaration (nm, vars, Equality (lhs,rhs), None) :: rest
         -> (* no hint, so let's prove this *)
            prove rules lhs rhs :: prover ((nm,get_string(vars),lhs,rhs)::rules) rest
      | ProofDeclaration (nm, vars, Equality (lhs,rhs), _) :: rest
         -> (* we got a hint so we simply assume the statement *)
            prover ((nm,get_string(vars),lhs,rhs)::rules) rest
      | [] -> []

      let prover_main decls =
        prover [] decls |>
        List.map (String.concat "\n") |>
        String.concat "\n\n" |>
        print_endline

    
    let print_subst (s:Substitution.t) = Substitution.MM.iter (fun k v -> print_endline (k ^" -> "^string_of_expression v)) s







