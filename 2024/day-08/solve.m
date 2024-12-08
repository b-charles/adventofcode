
M = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
S = size(M);

A = false( S );

for f = setdiff( unique(M), '.' )'

  CP = nchoosek( find( M == f ), 2 );
  [ P1I, P1J ] = ind2sub( S, CP(:,1) );
  [ P2I, P2J ] = ind2sub( S, CP(:,2) );
  T = [ 2*P1I-P2I 2*P1J-P2J ; 2*P2I-P1I 2*P2J-P1J ];
  T( T(:,1)<1 | S(1)<T(:,1) | T(:,2)<1 | S(2)<T(:,2), : ) = [];
  A( sub2ind( S, T(:,1), T(:,2) ) ) = true;

end

sum( A(:) )

%%

A = false( S );

for f = setdiff( unique(M), '.' )'
  for cp = nchoosek( find( M == f ), 2 )'
    [ p1i, p1j ] = ind2sub( size(M), cp(1) );
    [ p2i, p2j ] = ind2sub( size(M), cp(2) );

    k = 0;
    T = [ p1i-k*(p2i-p1i) p1j-k*(p2j-p1j) ];
    while 1<=T(1) && T(1)<=S(1) && 1<=T(2) && T(2)<=S(2)
      A( T(1), T(2) ) = true;
      k = k + 1;
      T = [ p1i-k*(p2i-p1i) p1j-k*(p2j-p1j) ];
    end

    k = 0;
    T = [ p2i+k*(p2i-p1i) p2j+k*(p2j-p1j) ];
    while 1<=T(1) && T(1)<=S(1) && 1<=T(2) && T(2)<=S(2)
      A( T(1), T(2) ) = true;
      k = k + 1;
      T = [ p2i+k*(p2i-p1i) p2j+k*(p2j-p1j) ];
    end

  end
end

sum( A(:) )
