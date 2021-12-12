
[ N, M ] = readin( 'input.txt' );

n = length( N );
s = find( N == 'start' );
e = find( N == 'end' );

L = cellfun( @isempty, regexp( N, '[a-z]+' ) );
MAX = ones( 1, n );
MAX( L ) = Inf;

length( paths( M, s, e, zeros(1,n), @(V) V == MAX ) )

%%

se = [ s e ];
small = setdiff( setdiff( 1:n, find(L) ), se );
length( paths( M, s, e, zeros(1,n), @(V)can_visit_2( V, n, small, se ) ) )

%%

function P = paths( A, i, j, V, update_visit )

N = find( A(i,:) );

V(i) = V(i) + 1;
nomore = update_visit( V );
A( nomore, : ) = 0;
A( :, nomore ) = 0;

P = {};
for k = N

  if k==j
    P{end+1} = [ i j ]; %#ok<AGROW>
  else
    Q = cellfun( @(p) [ i p ], paths( A, k, j, V, update_visit ), 'UniformOutput', false );
    P = { P{:} Q{:} }; %#ok<CCAT>
  end

end

end

function nomore = can_visit_2( V, n, small, se )
nomore = false( 1, n );
if max( V(small) ) == 2
  nomore(small) = V(small) >= 1;
end
nomore(se) = V(se) >= 1;
end
