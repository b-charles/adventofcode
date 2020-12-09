
V = uint64( str2num( fileread( 'data.in' ) ) ); %#ok<ST2NM>
n = length( V );
p = 25;

C = nchoosek( 1:p, 2 );
v = V( p + find( ~arrayfun( @(i) any( sum( V(C+i-p-1), 2 ) == V(i) ), (p+1):n ), 1 ) );
disp( v );

%%

I = nchoosek( 1:n, 2 );
I( I(:,2) - I(:,1) < 1, : ) = [];

f = find( arrayfun( @(s,e) sum( V(s:e) ) == v, I(:,1), I(:,2) ), 1 );

C = V(I(f,1):I(f,2));
disp( min(C) + max(C) );

