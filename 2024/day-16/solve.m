
I = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
W2 = find( I == '#' );
[ Ei, Ej ] = find( I ~= '#' );
[ si, sj ] = find( I == 'S', 1, 'first' );
[ ei, ej ] = find( I == 'E', 1, 'first' );

% Order: E / N / W / S

Z = nan( [ size(I) 4 ] );
Zp = Z;
O = ones(size(Ei,1), 1);
T = [ sub2ind( size(Z), Ei, Ej, 1*O ) ...
  sub2ind( size(Z), Ei, Ej, 2*O ) ...
  sub2ind( size(Z), Ei, Ej, 3*O ) ...
  sub2ind( size(Z), Ei, Ej, 4*O ) ];
Z( T ) = Inf;
Z( si, sj, 1 ) = 0;

[ MI, MJ ] = meshgrid( 1:size(I,1), 1:size(I,2) );
INF1 = Inf( size(I,1), 1 );
INF2 = Inf( 1, size(I,2) );
FALSE1 = false( size(I,1), 1 );
FALSE2 = false( 1, size(I,2) );
TRUE1 = true( size(I,1), 1 );
TRUE2 = true( 1, size(I,2) );

while any( Zp(T) ~= Z(T), 'all' )

  Zp = Z;

  Ve = [ INF1 Z(:,1:end-1,1) ]; Ve( W2 ) = nan;
  Ze = min( cat( 3, Z(:,:,1), Ve + 1, Z(:,:,2) + 1000, Z(:,:,3) + Inf, Z(:,:,4) + 1000 ), [], 3 );

  Vn = [ Z(2:end,:,2) ; INF2 ]; Vn( W2 ) = nan;
  Zn = min( cat( 3, Z(:,:,2), Z(:,:,1) + 1000, Vn + 1, Z(:,:,3) + 1000, Z(:,:,4) + Inf ), [], 3 );

  Vw = [ Z(:,2:end,3) INF1 ]; Vw( W2 ) = nan;
  Zw = min( cat( 3, Z(:,:,3), Z(:,:,1) + Inf, Z(:,:,2) + 1000, Vw + 1, Z(:,:,4) + 1000 ), [], 3 );

  Vs = [ INF2 ; Z(1:end-1,:,4) ]; Vs( W2 ) = nan;
  Zs = min( cat( 3, Z(:,:,4), Z(:,:,1) + 1000, Z(:,:,2) + Inf, Z(:,:,3) + 1000, Vs + 1 ), [], 3 );

  Z = cat( 3, Ze, Zn, Zw, Zs );

end

S = min( Z, [], 3 );
S( ei, ej )

%%

Q = false( size(I) );
Qn = Q;
Q( ei, ej ) = true;

while any( Q ~= Qn, 'all' )

  Qn = Q;

  Q = Q | ...
    ( [ FALSE1 Q(:,1:end-1) ] & [ INF1 S(:,1:end-1) ] > S ) | ...
    ( [ Q(2:end,:) ; FALSE2 ] & [ S(2:end,:) ; INF2 ] > S ) | ...
    ( [ Q(:,2:end) FALSE1 ] & [ S(:,2:end) INF1 ] > S ) | ...
    ( [ FALSE2 ; Q(1:end-1,:) ] & [ INF2 ; S(1:end-1,:) ] > S );
  Q = Q | ...
    ( [ FALSE1 FALSE1 Q(:,1:end-2) ] & [ TRUE1 Q(:,1:end-1) ] & [ INF1 INF1 S(:,1:end-2) ] > S ) | ...
    ( [ Q(3:end,:) ; FALSE2 ; FALSE2 ] & [ Q(2:end,:) ; TRUE2 ] & [ S(3:end,:) ; INF2 ; INF2 ] > S ) | ...
    ( [ Q(:,3:end) FALSE1 FALSE1 ] & [ Q(:,2:end) TRUE1 ] & [ S(:,3:end) INF1 INF1 ] > S ) | ...
    ( [ FALSE2 ; FALSE2 ; Q(1:end-2,:) ] & [ TRUE2 ; Q(1:end-1,:) ] & [ INF2 ; INF2 ; S(1:end-2,:) ] > S );

end

sum( Q, 'all' )
