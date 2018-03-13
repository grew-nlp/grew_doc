open Libgrew
open Conll

let pos_to_ssq = Grs.load "/users/guillaum/gitlab/grew/POStoSSQ/grs/surf_synt_main.grs"
let dom_pos_to_ssq = Grs.domain pos_to_ssq

let ssq_to_dsq = Grs.load "/users/guillaum/gitlab/grew/SSQtoDSQ/grs/main_dsq.grs"
let dom_ssq_to_dsq = Grs.domain ssq_to_dsq

let dsq_to_deep = Grs.load "/users/guillaum/gitlab/deep-sequoia/tools/sequoia_proj.grs"
let dom_dsq_to_deep = Grs.domain dsq_to_deep


let main () =
  let pos = "La/DET/le souris/NC/souris a/V/avoir été/VPP/être mangée/VPP/manger par/P/par le/DET/le chat/NC/chat" in

  let graph_0 = Graph.of_brown pos in

  let graph1__pos_to_ssq = match Rewrite.simple_rewrite ~gr:graph_0 ~grs:pos_to_ssq ~strat:"main" with
      | [one] -> one
      | _ -> failwith "[pos_to_ssq] several graphs: not managed" in

  let conll1 = Graph.to_conll ?domain:dom_pos_to_ssq graph1__pos_to_ssq in
  let graph1__ssq_to_dsq = Graph.of_conll ?domain:dom_ssq_to_dsq conll1 in

  let graph2__ssq_to_dsq = match Rewrite.simple_rewrite ~gr:graph1__ssq_to_dsq ~grs:ssq_to_dsq ~strat:"main" with
      | [one] -> one
      | _ -> failwith "[ssq_to_dsq] several graphs: not managed" in

  let conll2 = Graph.to_conll ?domain:dom_ssq_to_dsq graph2__ssq_to_dsq in
  let graph2__dsq_to_deep = Graph.of_conll ?domain:dom_dsq_to_deep conll1 in

  let graph3__dsq_to_deep = match Rewrite.simple_rewrite ~gr:graph2__dsq_to_deep ~grs:dsq_to_deep ~strat:"deep" with
      | [one] -> one
      | _ -> failwith "[ssq_to_dsq] several graphs: not managed" in
  let conll3 = Graph.to_conll ?domain:dom_dsq_to_deep graph3__dsq_to_deep in

  Printf.printf "========= graph1 =========\n%s" (Conll.to_string conll1);

  Printf.printf "========= graph2 =========\n%s" (Conll.to_string conll2);

  Printf.printf "========= graph3 =========\n%s" (Conll.to_string conll3);

  ()
let _ = main ()
