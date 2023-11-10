open Halloween

let rec keep_getting_input () =
  try
    let line = input_line stdin in
    let contents = parse line in
    let () = print_int (List.length contents) in
    let () = print_newline () in
    keep_getting_input ()
  with
    End_of_file -> ()
let _ = keep_getting_input ()
