
R = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) == '@';

N = ones( 3 );
keep = @( R ) R & conv2( R, N, 'same' ) > 4;

sum( R & ~keep( R ), 'all' )

%%

P = R;
S = keep( R );
while any( P ~= S, 'all' )
  P = S;
  S = keep( S );
end

sum( R & ~S, 'all' )
