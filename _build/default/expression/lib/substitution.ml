type identifier = string

 type typedVar = 
 |TypeVariable of (string * string)

 type astrik = 
 |AstrikType of astrik * astrik
 |LastAstrik of string
 
 type constructor = 
 |NormalType of string * astrik
 |SimpleType of string
 
 type hint=
 |Axiom
 |Induction of string

 type expression =
 |Application of expression * expression
 |Comma of expression * expression
 |Colon of expression * expression
 |Identifier of string
 |Express of expression * string

 type element=
 |Construct of constructor
 |ArrowStatement of expression * expression
 
 type vert=
 |Vertical of element 


 type equality = 
 |Equality of (expression * expression)

 type match_statement=
 |Matching of (string * vert list)

 type declaration = 
 |ProofDeclaration of (string * typedVar list * equality * hint option)
 |TypeDeclaration of (string * vert list)
 |RecDeclaration of (string* typedVar list * string * match_statement)

(*--------------------------------------------------------------------------------------*)
(* Substitution module as previously defined *)
module Substitution = struct
  module MM = Map.Make(String)
  type 'a t = 'a MM.t

  let empty = MM.empty
  let singleton = MM.singleton
  let merge = MM.merge
end

type substitution = expression Substitution.t

(* Function to apply substitutions stored in a map to an expression *)
let rec apply_substitutions substs expr = 
  match expr with
  | Identifier id -> 
      (try Substitution.MM.find id substs with Not_found -> expr)
  | Application (e1, e2) -> 
      Application (apply_substitutions substs e1, apply_substitutions substs e2)
  | Comma (e1, e2) -> 
      Comma (apply_substitutions substs e1, apply_substitutions substs e2)
  | Colon (e1, e2) -> 
      Colon (apply_substitutions substs e1, apply_substitutions substs e2)
  | Express (e, s) -> 
      Express (apply_substitutions substs e, s)
  

(* Function to match an expression against the lhs of an equality *)
let rec match_expressions lhs expr =
  match (lhs, expr) with
  | (Identifier id, _) -> Some (Substitution.singleton id expr)
  | (Application (l1, l2), Application (e1, e2))
  | (Comma (l1, l2), Comma (e1, e2))
  | (Colon (l1, l2), Colon (e1, e2)) ->
      (match (match_expressions l1 e1, match_expressions l2 e2) with
      | (Some subst1, Some subst2) -> 
          Some (Substitution.merge (fun _ a _ -> a) subst1 subst2)
      | _ -> None)
  | _ -> None

(* Function to attempt to rewrite an expression using an equality *)
let rec attemptRewrite equality expr =
  match equality with
  | Equality (lhs, rhs) ->
      match match_expressions lhs expr with
      | Some substs -> Some (apply_substitutions substs rhs)
      | None ->
          (match expr with
          | Application (e1, e2)
          | Comma (e1, e2)
          | Colon (e1, e2) ->
              (match attemptRewrite equality e1 with
              | Some new_e1 -> Some (Application (new_e1, e2))
              | None ->
                  (match attemptRewrite equality e2 with
                  | Some new_e2 -> Some (Application (e1, new_e2))
                  | None -> None))
          | _ -> None)


(*Testing with One Example*)

          (* Equality (Pattern A) *)
let eqA = Equality(
    Application(Identifier "map", Identifier "fn"), 
    Application(Identifier "fn", Identifier "x")
)


(* Expression (Goal) *)
let goalExpr = Application(
    Identifier "map", 
    Application(
        Identifier "map", 
        Application(
            Identifier "g", 
            Identifier "x"
        )
    )
)

let rec string_of_expression ( e : expression ) 
= match e with
| Identifier nm -> nm
| Application (e1,e2) -> (string_of_expression e1)^" ("^
   (string_of_expression e2)^")"
| Express (e1,e2)->string_of_expression e1^" "^e2
| Comma (a,b) -> "("^string_of_expression a^" , "^string_of_expression b^")"
| Colon (a,b) -> string_of_expression a^" : "^string_of_expression b

let string_of_equality (e:equality)
= match e with
|Equality(a,b)->string_of_expression(a)^" = "^string_of_expression(b)

  



(* Assuming type definitions for expression and equality *)

(* Function to perform a proof step and print details *)
let perform_proof_step equality goal =
    match equality with
    | Equality (lhs, rhs) ->
        match match_expressions lhs goal with
        | Some substs ->
            let transformed_goal = apply_substitutions substs rhs in
            print_endline (string_of_expression goal);
            print_string "= {left hand side: ";
            Substitution.MM.iter (fun var expr -> 
              print_string (var ^ ":=" ^ string_of_expression expr ^ ", ")
            ) substs;
            print_endline "}";
            print_endline (string_of_expression transformed_goal);
            Some transformed_goal
        | None ->
            print_endline "No match found for the goal with the given equality.";
            None

        let () = 
  let _ = perform_proof_step eqA goalExpr in
  ()