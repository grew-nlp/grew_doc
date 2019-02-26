# This file contains sed commands to transform talismane output to a CoNLL format suitable for parsing with Grew
# See http://grew.fr/parsing/ for more information

# --------------------------------------
# Step 1: add columns to have 10 columns
s/	$/	_	_	_	_/

# --------------------------------------
# Step 2: replace column 4 by "_"
s/ADJ	ADJ/_	ADJ/
s/ADJWH	ADJWH/_	ADJWH/
s/ADV	ADV/_	ADV/
s/ADVWH	ADVWH/_	ADVWH/
s/CC	CC/_	CC/
s/CLO	CLO/_	CLO/
s/CLR	CLR/_	CLR/
s/CLS	CLS/_	CLS/
s/CS	CS/_	CS/
s/DET	DET/_	DET/
s/DETWH	DETWH/_	DETWH/
s/ET	ET/_	ET/
s/I	I/_	I/
s/NC	NC/_	NC/
s/NPP	NPP/_	NPP/
s/P	P/_	P/
s/P+D	P+D/_	P+D/
s/P+PRO	P+PRO/_	P+PRO/
s/PONCT	PONCT/_	PONCT/
s/PREF	PREF/_	PREF/
s/PRO	PRO/_	PRO/
s/PROREL	PROREL/_	PROREL/
s/PROWH	PROWH/_	PROWH/
s/V	V/_	V/
s/VIMP	VIMP/_	VIMP/
s/VINF	VINF/_	VINF/
s/VPP	VPP/_	VPP/
s/VPR	VPR/_	VPR/
s/VS	VS/_	VS/

# --------------------------------------
# Step 3: Change features

# Step 3.1: Talismane use the comma to deal with ambiguities. This is rewritten or removed
# NOTE: this list may not be exhaustive and should be extended if needed
s/t=P,S/t=pst/
s/t=J,P/m=ind/
s/g=f,m//
s/n=p,s//
s/p=1,3//
s/p=1,2//

# Step 3.2: Feature removing may cause wrong features syntax, following lines fix this.
s/	|/	/
s/|	/	/
s/|||/|/
s/||/|/

# Step 3.3: possessives
s/poss=s/s=poss/
s/poss=p/s=poss/

# Step 3.4: possessives
# verbal features
s/t=C/m=ind|t=cond/
s/t=F/m=ind|t=fut/
s/t=G/m=part|t=pst/
s/t=I/m=ind|t=impft/
s/t=J/m=ind|t=past/
s/t=K/m=part|t=past/
s/t=P/m=ind|t=pst/
s/t=T/m=subj|t=past/
s/t=S/m=subj|t=pst/
s/t=W/m=inf/
s/t=Y/m=imp|t=pst/

