function P = path( B, I )

D = [ -1 0 0 ; 0 1 0 ; 1 0 0 ; 0 -1 0 ];
S = size( B );

BUF = zeros( 1000, 3 );
P = BUF;
P(1,:) = I;
e = 1;

while true

  Pn = P(e,:) + D( P(e,3), : );

  if Pn(1) < 1 || S(1) < Pn(1) || Pn(2) < 1 || S(2) < Pn(2)
    P(e, 3) = 0;
    break
  end

  if B( Pn(1), Pn(2) )
    T = P(e,:);
    while B( Pn(1), Pn(2) )
      T(3) = mod( T(3), 4 ) + 1;
      Pn = T + D( T(3), : );
    end
    if ismember( Pn, P, 'rows' )
      break
    end
  end

  e = e + 1;
  if e > size( P, 1 )
    P = [ P ; BUF ]; %#ok<AGROW>
  end
  P(e,:) = Pn;

end

P = P(1:e,:);

end