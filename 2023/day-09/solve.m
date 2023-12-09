
V = arrayfun( @str2num, readlines( 'input.txt', 'EmptyLineRule', 'skip' ) , 'UniformOutput', false );
n = length(V);

E = zeros( n, 2 );
for i = 1:n

  v = V{i};
  o = [];
  while any( v ~= 0 )
    o = [ v(1) o ]; %#ok<AGROW> 
    v = diff( v );
  end

  e = [ 0 v 0 ];
  for k = 1:length(o)
    e = [ (o(k)-e(1)) cumsum( [ o(k) e(2:end) ] ) ];
  end
  E(i,:) = [ e(1) e(end) ];

end

uint64( sum(E(:,2)) )

%%

uint64( sum(E(:,1)) )
