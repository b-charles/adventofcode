
M = readin( 'input.txt' );

sum( [ 1 100 ] * [ cellfun( @(m) lookForSym( m, 0 ), M ) ; cellfun( @(m) lookForSym( m', 0 ), M ) ] )

%%

sum( [ 1 100 ] * [ cellfun( @(m) lookForSym( m, 1 ), M ) ; cellfun( @(m) lookForSym( m', 1 ), M ) ] )

%%

function S = lookForSym( M, t )

n = size(M,2);
for S = 1:size(M,2)-1
  A = M( :, max(2*S-n+1,1):S );
  B = M( :, min(2*S,n):-1:S+1 );
  if sum( A(:) ~= B(:) ) == t
    return
  end
end
S = 0;

end
