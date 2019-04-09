pattern {
	NS -[user=*]-> N1; NS -[user=*]-> N2; % N1 and N2 are parallel
	e1: G1 -> N1;                         % G1 is the governor of N1
	e2: G2 -> N2;                         % G2 is the governor of N2
	id(G1) < id(G2);                      % avoid duplicates (1/2 switching)
}
without {
	GS -> G1; GS -> G2                    % G1 and G2 are not parallel
}
