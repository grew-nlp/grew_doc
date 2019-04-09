pattern {
	NS -[user=*]-> N1; NS -[user=*]-> N2; % N1 and N2 are parallel
	MS -[user=*]-> M1; MS -[user=*]-> M2; % M1 and M2 are parallel
	e1: M1 -> N1; e2: M2 -> N2;           % M and N are link by parallel edges
	label(e1) <> label(e2);               % ask to different labels
	id(N1) < id(N2);                      % avois duplicate (1/2 switching)
}
