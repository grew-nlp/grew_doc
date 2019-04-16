pattern {
	N1[]; N2[]; N1.position = N2.position; N1.user <> N2.user; % N1 and N2 are parallel
	M1[]; M2[]; M1.position = M2.position; M1.user <> M2.user; % M1 and M2 are parallel
	e1: M1 -> N1; e2: M2 -> N2;                                % M and N are link by parallel edges
	label(e1) <> label(e2);                                    % ask to different labels
	id(N1) < id(N2);                                           % avois duplicate (1/2 switching)
}
