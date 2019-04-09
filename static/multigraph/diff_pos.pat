pattern {
	NS -[user=*]-> N1; NS -[user=*]-> N2; % N1 and N2 are parallel
	N1.upos <> N2.upos;                   % N1 and N2 have ≠ upos features
	id(N1) < id(N2);                      % force internal identifiers ordering to avoid duplicates
}
