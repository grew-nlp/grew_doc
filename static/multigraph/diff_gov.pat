pattern {
	N1[]; N2[]; N1.position = N2.position; N1.user <> N2.user; % N1 and N2 are parallel
	e1: G1 -> N1;                                              % G1 is the governor of N1
	e2: G2 -> N2;                                              % G2 is the governor of N2
	id(G1) < id(G2);                                           % avoid duplicates (1/2 switching)
	G1.position <> G2.position;                                % G1 and G2 are not parallel
}
