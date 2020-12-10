
J = str2num( fileread( 'data.in' ) )'; %#ok<ST2NM>

V = [ 0 sort( J ) max(J)+3 ];

D = diff( V );
disp( sum( D == 1 ) * sum( D == 3 ) );

%%

n = length(V);
D = [ 9 9 V(4:n)-V(1:n-3) ; 9 V(3:n)-V(1:n-2) ; zeros(1,n-1) ] <= 3;

N = [ 1 1 1 ];
for i = 1:n-1
  N = [ N(2) N(3) N*D(:,i) ];
end

disp( N(3) )
