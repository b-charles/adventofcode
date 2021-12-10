
S = simplify( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );

P = cellfun( @(s) regexprep( s, '.*[\(\[\{<]([\)\]\}>]).*', '$1', 'once' ), S, 'UniformOutput', false );
C = cellfun( @(p) length(p) == 1, P );

sum( cellfun( @(s) sum( 3*(s==')') + 57*(s==']') + 1197*(s=='}') + 25137*(s=='>') ), P(C) ) )

%%

median( uint64( cellfun( @(s) sum( 5.^(0:length(s)-1) .* ( (s=='(') + 2*(s=='[') + 3*(s=='{') + 4*(s=='<') ) ), S(~C) ) ) )

%%

function L = simplify( L )
  P = zeros( size( L ) );
  N = strlength( L );
  while( any( P ~= N ) )
    P = N;
    L = regexprep( L, '\(\)|\[\]|\{\}|<>', '' );
    N = strlength( L );
  end
end
