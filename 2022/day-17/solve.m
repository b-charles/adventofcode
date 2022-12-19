
J = ( convertStringsToChars( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) == '>' ) * 2 - 1;

R = { ...
  [ 1 3 ; 1 4 ; 1 5 ; 1 6 ] ...
  [ 1 4 ; 2 3 ; 2 4 ; 2 5 ; 3 4 ] ...
  [ 1 5 ; 2 5 ; 3 3 ; 3 4 ; 3 5 ] ...
  [ 1 3 ; 2 3 ; 3 3 ; 4 3 ] ...
  [ 1 3 ; 1 4 ; 2 3 ; 2 4 ] };

H = zeros( 0, 1 );
S = zeros( 0, 9 );

P = ones( 1, 7 );
j = 1;
r = 1;
while true
  [ P, j ] = fallRock( P, R{r}, J, j );
  H(end+1) = size(P,1) - 1; %#ok<*SAGROW>
  s = [ r, j, arrayfun( @(c) find(P(:,c),1), 1:7 ) ];
  [ ~, c ] = intersect( S, s, 'rows' );
  S(end+1,:) = s;
  if ~isempty(c)
    break
  end
  r = mod( r, 5 ) + 1;
end
l = length(H);

height = @(nbr) floor( (nbr-c+1) / (l-c) )*(H(l)-H(c)) + H( c-1 + mod(nbr-c+1,l-c) );

height( 2022 )

%%

uint64( height( 1e12 ) )

%%

function [ P, j ] = fallRock( P, R, J, j )

P = [ zeros( max(R(:,1))+3, 7) ; P ];
sP = size(P);

Y = R(:,1);
X = R(:,2);

while all( Y<=size(P,1) ) && all( ~P( sub2ind( sP, Y, X ) ) )

  N = X + J(j);
  if all( N>=1 & N<=7 ) && all( ~P( sub2ind( sP, Y, N ) ) )
    X = N;
  end
  j = mod( j, length(J) ) + 1;

  Y = Y+1;

end

P( sub2ind( size(P), Y-1, X ) ) = true;
P = P( find(any(P,2),1):end, : );

end