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
       
    exception Match_expr_exception
    let merge map1 map2=
      let helper _ m1 m2 =
        match m1, m2 with
        |Some m, None -> Some m
        |None, Some m->Some m
        |Some m1, Some m2 -> if m1=m2 then (Some m1) else Match_expr_exception
        |None, None -> None
      in MM.merge helper map1 map2
     
    let find=MM.find
    (* Screw this part :( *)
    let rec match_expression (variables:string list) (pattern:expression) (goal:expression) : t =
      match pattern, goal with
      | Identifier pattern, _ when List.mem pattern variables -> singleton pattern goal
      | Identifier pattern, Identifier goal when pattern = goal -> empty
      | Application (a1, a2), Application (b1, b2) -> merge (match_expression variables a1 b1) (match_expression variables a2 b2)
      | _,_->raise Match_expr_exception

    let rec tryStep variables lhs rhs expr
      = match match_expression variables lhs expr with
         s -> Some rhs (* fix: use substitution *)
         | exception Match_expr_exception -> (match expr with
            | Identifier _ -> None
            | Application a b -> try a first, then try b
            )

      
    let rec substitute (variables:string list) (map: t) (exp:expression) : expression = 
      match exp with
      |Identifier nm -> (try
                          find nm map
                        with
                        | Not_found -> exp)
      |Application(e1,e2)->Application(substitute(variables)(map)(e1),substitute(variables)(map)(e2))

    
    let tryEqualities (equalities : (string * string list * expression * expression) list) (exp : expression) : (string * expression) option =
      let rec tryEqualitiesHelper equation =
        match equation with
        | [] -> None
        | (equationNumber, variables, pattern, goal) :: tl ->
          let substitutionMap = match_expression variables pattern exp in
          match substitutionMap with
          | _ when substitutionMap <> empty ->
            let substitutedGoal = substitute variables substitutionMap goal in
            Some (equationNumber, substitutedGoal)
          | _ -> tryEqualitiesHelper tl
      in tryEqualitiesHelper equalities
      
    let rec performSteps (equalities : (string * string list * expression * expression) list) (exp : expression) : (string * expression) list=
        match (tryEqualities (equalities) (exp)) with
        |None->[]
        |Some (equationNumber, goal)-> (equationNumber,goal)::performSteps equalities goal

    


    let print_subst (s:t) = MM.iter (fun k v -> print_endline (k ^" -> "^string_of_expression v)) s
end



