Prism.languages.grew = {
	'comment': /%.*/,

	'keyword': /\b(?:rule|from|pattern|without|global|commands|graph|package|rule|strat|import|include)\b/,
	'command': /\b(?:del_edge|add_edge|shift|shift_in|shift_out|del_node|add_node|del_feat|unorder|insert|prepend_feats|append_feats)\b/,
	'strat': /\b(?:Iter|Pick|Alt|Seq|If|Empty|Try|Onf)\b/,
	'constant': /\b(?:STRING|NUMERIC)\b/,
	'string': [
		{
			pattern: /"(?:\\.|[^\\\r\n"])*"/,
			greedy: true
		},
		{
			pattern: /(['`])(?:\\(?:\d+|x[\da-f]+|.)|(?!\1)[^\\\r\n])\1/i,
			greedy: true
		}
	],
	'operator': {
			pattern: /<<|<|>|>>|:<|:>|->|-\[|\]->|==>|=\[|\]=>/,
			greedy:true
		},
};

Prism.languages.ocaml = {
	'comment': /\(\*[\s\S]*?\*\)/,
	'string': [
		{
			pattern: /"(?:\\.|[^\\\r\n"])*"/,
			greedy: true
		},
		{
			pattern: /(['`])(?:\\(?:\d+|x[\da-f]+|.)|(?!\1)[^\\\r\n])\1/i,
			greedy: true
		}
	],
	'number': /\b-?(?:0x[\da-f][\da-f_]+|(?:0[bo])?\d[\d_]*\.?[\d_]*(?:e[+-]?[\d_]+)?)/i,
	'type': {
		pattern: /\B['`][a-z\d_]*/i,
		alias: 'variable'
	},
	'directive': {
		pattern: /\B#[a-z\d_]+/i,
		alias: 'function'
	},
	'keyword': /\b(?:as|assert|begin|class|constraint|do|done|downto|else|end|exception|external|for|fun|function|functor|if|in|include|inherit|initializer|lazy|let|match|method|module|mutable|new|object|of|open|prefix|private|rec|then|sig|struct|to|try|type|val|value|virtual|where|while|with)\b/,
	'boolean': /\b(?:false|true)\b/,
	// Custom operators are allowed
	'operator': /:=|[=<>@^|&+\-*\/$%!?~][!$%&\*+\-.\/:<=>?@^|~]*|\b(?:and|asr|land|lor|lxor|lsl|lsr|mod|nor|or)\b/,
	'punctuation': /[(){}\[\]|_.,:;]/
};
