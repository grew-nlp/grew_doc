pattern {
	N1[]; N2[]; N1.position = N2.position; N1.user <> N2.user; % N1 and N2 are parallel
	N1.upos <> N2.upos;                                        % N1 and N2 have ≠ upos features
	id(N1) < id(N2);                                           % force internal identifiers ordering to avoid duplicates
}
