+++
date = "2020-10-02"
title = "libgrew"

+++

# Changes in libgrew 1.3 &rarr; 1.4

 * Module `Multigraph` REMOVED
 * Module `Corpus` ADDED
 * Module `Corpus_desc` ADDED

## `Pattern`

### Types change
 * `load`
   * OLD: `val load: ?domain:Domain.t -> string -> t`
   * NEW: `val load: ?domain:Domain.t -> config:Conllx_config.t -> string -> t`

 * `parse`
   * OLD: `val parse: ?domain:Domain.t -> string -> t`
   * NEW: `val parse: ?domain:Domain.t -> config:Conllx_config.t -> string -> t`

## `Matching`

### Renamed
 * `get_value` &rarr; `get_value_opt`
   * `val get_value: string -> Pattern.t -> Grew_graph.G_graph.t -> t -> string option`
   * `val get_value_opt: config:Conllx_config.t -> string -> Pattern.t -> Grew_graph.G_graph.t -> t -> string option`

## `Graph`

### Types change
 * `load`
   * OLD: `val load: ?domain:Domain.t -> string -> t`
   * NEW: `val load: ?domain:Domain.t -> config:Conllx_config.t -> string -> t`

 * `of_gr`
   * OLD: `of_gr: ?domain:Domain.t -> string -> t`
   * NEW: `val of_gr: ?domain:Domain.t -> config:Conllx_config.t -> string -> t`

 * `of_conll`
   * OLD: `val of_conll: ?domain:Domain.t -> Conll.t -> t`
   * NEW: `val of_conll: ?domain:Domain.t -> config:Conllx_config.t -> Conll.t -> t`

 * `of_brown`
   * OLD: `val of_brown: ?domain:Domain.t -> ?sentid:string -> string -> t`
   * NEW: `val of_brown: ?domain:Domain.t -> config:Conllx_config.t -> ?sentid:string -> string -> t`

 * `to_sentence`
   * OLD: `val to_sentence: ?only_pivot: bool -> ?main_feat:string -> ?deco:Deco.t -> t -> string`
   * NEW: `val to_sentence: ?pivot: string -> ?deco:Deco.t -> t -> string`

 * `to_orfeo`
   * OLD: `val to_orfeo: ?deco:Deco.t -> t -> string`
   * NEW: `val to_orfeo: ?deco:Deco.t -> t -> string   * (float   * float) option`

 * `to_dot`
   * OLD: `val to_dot : ?main_feat:string -> ?deco:Deco.t -> ?get_url:(string -> string option) -> t -> string`
   * NEW: `val to_dot : ?main_feat:string -> config:Conllx_config.t -> ?deco:Deco.t -> ?get_url:(string -> string option) -> t -> string`

 * `to_dep`
   * OLD: `val to_dep : ?filter: (string -> bool) -> ?main_feat:string -> ?deco:Deco.t -> t -> string`
   * NEW: `val to_dep : ?filter: (string -> bool) -> ?main_feat:string -> ?deco:Deco.t -> config:Conllx_config.t -> t -> string`

 * `to_gr`
   * OLD: `val to_gr: t -> string`
   * NEW: `val to_gr: config:Conllx_config.t -> t -> string`

 * `to_conll`
   * OLD: `val to_conll: t -> Conll.t`
   * NEW: `val to_conll: config:Conllx_config.t -> t -> Conll.t`

 * `to_conll_string`
   * OLD: `val to_conll_string: ?cupt:bool -> t -> string`
   * NEW: `val to_conll_string: ?cupt:bool -> config:Conllx_config.t -> t -> string`

 * `search_pattern`
   * OLD: `val search_pattern: ?domain:Domain.t -> Pattern.t -> t -> Matching.t list`
   * NEW: `val search_pattern: ?domain:Domain.t -> config:Conllx_config.t -> Pattern.t -> t -> Matching.t list`

### New functions:
   * `val of_json_python: config:Conllx_config.t -> Yojson.Basic.t -> t`
   * `val to_json_python: t -> Yojson.Basic.t`
   * `val get_meta_opt: string -> t -> string option`
   * `val get_meta_list: t -> (string * string) list`
   * `val set_meta: string -> string -> t -> t`

## `Grs`

### Renamed

 * `domain` &rarr; `domain_opt`
 * `to_json` &rarr; `to_json_python`
   * OLD: `t -> Yojson.Basic.t`
   * NEW: `val to_json_python: config:Conllx_config.t -> t -> Yojson.Basic.t`

### Type change

 * `load`
  * OLD: `val to_json: t -> Yojson.Basic.t`
  * NEW: `val to_json_python: config:Conllx_config.t -> t -> Yojson.Basic.t`

### New function
  * `val parse: config:Conllx_config.t -> string -> t`

## `Rewrite`

### Type change

 * `display`
  * OLD: `val display: gr:Graph.t -> grs:Grs.t -> strat:string -> display`
  * NEW: `val display: config:Conllx_config.t -> Graph.t -> Grs.t -> string -> display`

 * `at_least_one`
  * OLD: `val at_least_one: grs:Grs.t -> strat:string -> bool`
  * NEW: `val at_least_one: Grs.t -> string -> bool`

 * `at_most_one`
  * OLD: `val at_most_one: grs:Grs.t -> strat:string -> bool`
  * NEW: `val at_most_one: Grs.t -> string -> bool`

 * `simple_rewrite`
  * OLD: `val simple_rewrite: gr:Graph.t -> grs:Grs.t -> strat:string -> Graph.t list`
  * NEW: `val simple_rewrite: config:Conllx_config.t -> Graph.t -> Grs.t -> string -> Graph.t list`

### New function
 * `val onf_rewrite_opt: config:Conllx_config.t -> Graph.t -> Grs.t -> string -> Graph.t option`


