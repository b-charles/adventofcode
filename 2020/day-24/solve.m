
% T = readin( 'demo1.in' );
T = readin( 'data.in' );

[ ~, ~, U ] = unique( T, 'rows' );
disp( sum( accumarray( U, ones(size(T,1), 1), [], @(t)mod(length(t),2)==1 ) ) );

%%

MinX = min(T(:,1)) - 200; MinX = MinX - mod(MinX,2);
MaxX = max(T(:,1)) + 200; MaxX = MaxX + mod(MaxX,2);

MinY = min(T(:,2)) - 100; MinY = MinY - mod(MinY,2);
MaxY = max(T(:,2)) + 100; MaxY = MaxY + mod(MaxY,2);

[ PX1, PY1 ] = ndgrid( MinX:2:MaxX, MinY:2:MaxY );
[ PX2, PY2 ] = ndgrid( MinX+1:2:MaxX-1, MinY+1:2:MaxY-1 );

PX = [ PX1(:) ; PX2(:) ]; PY = [ PY1(:) ; PY2(:) ];
n = length( PX );

f = @(X,Y) max( [ 0 find(X==PX&Y==PY,1) ] ) + 1;

N = zeros(n,6);
for i = 1:n
  N(i,:) = [ f(PX(i)+2,PY(i)) f(PX(i)+1,PY(i)+1) f(PX(i)-1,PY(i)+1) f(PX(i)-2,PY(i)) f(PX(i)-1,PY(i)-1) f(PX(i)+1,PY(i)-1) ];
end

V = false(n+1,1);
for k = 1:size(T,1)
  ind = f( T(k,1), T(k,2) );
  V(ind) = ~V(ind);
end

for k = 1:100
  S = [ 0 ; sum(V(N),2) ];
  V = ( V & (S==1) ) | (S==2);
end

disp( sum( V ) );
