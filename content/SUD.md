+++
date = "2018-04-06T11:29:34+02:00"
title = "SUD"
Description = ""
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]

+++

# Conversion SUD --> UD and UD --> SUD

[Projet gitlab du système de conversion](http://gitlab.inria.fr/grew/SUD)

## How to read graphs?
 * When the automatic conversion from the other format is identical to the gold annotation, everything is drawn in black
 * When the automatic conversion from the other format is different from the gold annotation:
   * common parts are drawn in black
   * gold annotation only is in yellow
   * result of the conversion is in green

## Examples from the first meeting
| id | SUD | UD |
|:---:|:---:|:---:|
| `je_t_aime` | ![](/_sud_diff/je_t_aime.svg) | ![](/_ud_diff/je_t_aime.svg) |
| `j_aime_P` | ![](/_sud_diff/j_aime_P.svg) | ![](/_ud_diff/j_aime_P.svg) |
| `je_te_parle` | ![](/_sud_diff/je_te_parle.svg) | ![](/_ud_diff/je_te_parle.svg) |
| `je_parle_a_M` | ![](/_sud_diff/je_parle_a_M.svg) | ![](/_ud_diff/je_parle_a_M.svg) |
| `on_nomme_Jean_N` | ![](/_sud_diff/on_nomme_Jean_N.svg) | ![](/_ud_diff/on_nomme_Jean_N.svg) |
| `il_fait_VINF_P` | ![](/_sud_diff/il_fait_VINF_P.svg) | ![](/_ud_diff/il_fait_VINF_P.svg) |
| `il_oblige_P_a_VINF` | ![](/_sud_diff/il_oblige_P_a_VINF.svg) | ![](/_ud_diff/il_oblige_P_a_VINF.svg) |
| `difficile_a_lire` | ![](/_sud_diff/difficile_a_lire.svg) | ![](/_ud_diff/difficile_a_lire.svg) |
| `possible_que` | ![](/_sud_diff/possible_que.svg) | ![](/_ud_diff/possible_que.svg) |
| `difficile_a_expliquer` | ![](/_sud_diff/difficile_a_expliquer.svg) | ![](/_ud_diff/difficile_a_expliquer.svg) |
| `avoir_besoin` | ![](/_sud_diff/avoir_besoin.svg) | ![](/_ud_diff/avoir_besoin.svg) |
| `est_gentil` | ![](/_sud_diff/est_gentil.svg) | ![](/_ud_diff/est_gentil.svg) |
| `reste_gentil` | ![](/_sud_diff/reste_gentil.svg) | ![](/_ud_diff/reste_gentil.svg) |
| `one_aux` | ![](/_sud_diff/one_aux.svg) | ![](/_ud_diff/one_aux.svg) |
| `one_pass` | ![](/_sud_diff/one_pass.svg) | ![](/_ud_diff/one_pass.svg) |
| `aux_and_pass` | ![](/_sud_diff/aux_and_pass.svg) | ![](/_ud_diff/aux_and_pass.svg) |
| `etre_oblique` | ![](/_sud_diff/etre_oblique.svg) | ![](/_ud_diff/etre_oblique.svg) |
| `etre_cop` | ![](/_sud_diff/etre_cop.svg) | ![](/_ud_diff/etre_cop.svg) |
| `tres_difficile` | ![](/_sud_diff/tres_difficile.svg) | ![](/_ud_diff/tres_difficile.svg) |
| `difficilement_lisible` | ![](/_sud_diff/difficilement_lisible.svg) | ![](/_ud_diff/difficilement_lisible.svg) |
| `beaucoup_de` | ![](/_sud_diff/beaucoup_de.svg) | ![](/_ud_diff/beaucoup_de.svg) |

## Some other examples
| id | SUD | UD |
|:---:|:---:|:---:|
| `par_P` | ![](/_sud_diff/par_P.svg) | ![](/_ud_diff/par_P.svg) |
| `par_son_nom` | ![](/_sud_diff/par_son_nom.svg) | ![](/_ud_diff/par_son_nom.svg) |
| `one_aux_neg` | ![](/_sud_diff/one_aux_neg.svg) | ![](/_ud_diff/one_aux_neg.svg) |
| `one_pass_neg` | ![](/_sud_diff/one_pass_neg.svg) | ![](/_ud_diff/one_pass_neg.svg) |
| `aux_and_pass_neg` | ![](/_sud_diff/aux_and_pass_neg.svg) | ![](/_ud_diff/aux_and_pass_neg.svg) |
| `ccomp_obj` | ![](/_sud_diff/ccomp_obj.svg) | ![](/_ud_diff/ccomp_obj.svg) |
| `ccomp_obl` | ![](/_sud_diff/ccomp_obl.svg) | ![](/_ud_diff/ccomp_obl.svg) |
| `aux_mark` | ![](/_sud_diff/aux_mark.svg) | ![](/_ud_diff/aux_mark.svg) |

## Examples from corpora
 * `Europar.550_00040`
    ![](/_sud_diff/Europar.550_00040.svg)
    ![](/_ud_diff/Europar.550_00040.svg)

 * `fr-ud-train_09696`
    ![](/_sud_diff/fr-ud-train_09696.svg)
    ![](/_ud_diff/fr-ud-train_09696.svg)

 * `fr-ud-train_11980`
    ![](/_sud_diff/fr-ud-train_11980.svg)
    ![](/_ud_diff/fr-ud-train_11980.svg)

 * `fr-ud-train_09113`
    {{< large file="_sud_diff/fr-ud-train_09113.svg" >}}
    {{< large file="_ud_diff/fr-ud-train_09113.svg" >}}

 * `fr-ud-dev_00204`
    {{< large file="_sud_diff/fr-ud-dev_00204.svg" >}}
    {{< large file="_ud_diff/fr-ud-dev_00204.svg" >}}

 * `fr-ud-dev_00131`
    {{< large file="_sud_diff/fr-ud-dev_00131.svg" >}}
    {{< large file="_ud_diff/fr-ud-dev_00131.svg" >}}

 * `fr-ud-dev_00131`
    {{< large file="_sud_diff/fr-ud-dev_00131.svg" >}}
    {{< large file="_ud_diff/fr-ud-dev_00131.svg" >}}
