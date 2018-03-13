open Libgrew
open Conll

let pos_to_ssq = Grs.load "/users/guillaum/gitlab/grew/POStoSSQ/grs/surf_synt_main.grs"
let ssq_to_dsq = Grs.load "/users/guillaum/gitlab/grew/SSQtoDSQ/grs/main_dsq.grs"
let dsq_to_deep = Grs.load "/users/guillaum/gitlab/deep-sequoia/tools/sequoia_proj.grs"

let main () =
  let pos = "La/DET/le souris/NC/souris a/V/avoir été/VPP/être mangée/VPP/manger par/P/par le/DET/le chat/NC/chat" in
  let pos_graph = Graph.of_brown pos in
  let ssq_graph = match Rewrite.simple_rewrite ~gr:pos_graph ~grs:pos_to_ssq ~strat:"main" with
      | [one] -> one
      | _ -> failwith "[pos_to_ssq] several graphs: not managed" in
  let dsq_graph = match Rewrite.simple_rewrite ~gr:ssq_graph ~grs:ssq_to_dsq ~strat:"main" with
      | [one] -> one
      | _ -> failwith "[ssq_to_dsq] several graphs: not managed" in
  let deep_graph = match Rewrite.simple_rewrite ~gr:dsq_graph ~grs:dsq_to_deep ~strat:"deep" with
      | [one] -> one
      | _ -> failwith "[dsq_to_deep] several graphs: not managed" in
  Printf.printf "========= ssq_graph =========\n%s" (Conll.to_string (Graph.to_conll ssq_graph));
  Printf.printf "========= dsq_graph =========\n%s" (Conll.to_string (Graph.to_conll dsq_graph));
  Printf.printf "========= deep_graph =========\n%s" (Conll.to_string (Graph.to_conll deep_graph));
  ()

let _ = main ()
