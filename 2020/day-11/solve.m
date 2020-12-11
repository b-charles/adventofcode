
% S = ( cell2mat( split( fileread( 'demo1.in' ) ) ) == 'L' );
S = ( cell2mat( split( fileread( 'data.in' ) ) ) == 'L' );

[ nx, ny ] = size( S );
[ I_Y, I_X ] = meshgrid( 1:ny, 1:nx );
PX = I_X(S); PY = I_Y(S);

np = size( PX, 1 );
ONE_NP = 1:np;

D = zeros( np, np ); T = zeros( np, np );
for p = ONE_NP
  DX = PX - PX(p); DY = PY - PY(p);
  D(:,p) = DX.^2 + DY.^2;
  T(:,p) = atan2( DY, DX ) / pi;
  T(p,p) = NaN;
end

%% phase 1

n1 = @(d,t) ONE_NP * ( ( D == d ) & ( T == t ) );
N = [ n1(1,1); n1(2,-0.75); n1(1,-0.5); n1(2,-0.25); n1(1,0); n1(2,0.25); n1(1,0.5); n1(2,0.75) ];

disp( sum( engine( N, 4 ) ) );

%% phase 2

n2 = @(TEQ) arrayfun( @(k) ONE_NP * (TEQ(:,k) & ( D(:,k) == min( [ inf; D(TEQ(:,k),k) ] ) ) ), ONE_NP );
N = [ n2(T==1); n2(T==-0.75); n2(T==-0.5); n2(T==-0.25); n2(T==0); n2(T==0.25); n2(T==0.5); n2(T==0.75) ];

disp( sum( engine( N, 5 ) ) );

%% engine

function V1 = engine( N, threshold )

N = N+1;

step = @(V,VN) ( ~V & [ false ~any(VN,1) ] ) | ( V & [ false sum(VN,1) < threshold ] );

V1 = false( 1, size( N, 2 ) + 1 );
V2 = step( V1, V1(N) );
while any( V1 ~= V2 )
  [ V1, V2 ] = deal( V2, step( V2, V2(N) ) );
end

end
