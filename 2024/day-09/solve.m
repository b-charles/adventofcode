
L = [ char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) - '0' 0 ];
LL = length(L);

ID = [ -ones( 1, LL ) ; cumsum( [ 0 L(1:end-1) ] ) ; L ];
ID( 1, 1:2:end ) = 0:(LL/2-1);

e = find( ID(1,:) == -1, 1, 'first' );
f = find( ID(1,:) ~= -1, 1, 'last' );
while e < f
  if ID(3,e) < ID(3,f)
    ID = [ ID(:,1:e-1) [ ID(1,f) ID(2,e) ID(3,e) ]' ID(:,e+1:f-1) [ ID(1,f) ID(2,f) ID(3,f)-ID(3,e) ]' ];
  elseif ID(3,e) > ID(3,f)
    ID = [ ID(:,1:e-1) [ ID(1,f) ID(2,e) ID(3,f) ]' [ -1 ID(2,e)+ID(3,f) ID(3,e)-ID(3,f) ]' ID(:,e+1:f-1) ];
  else % ID(3,e) == ID(3,l)
    ID = [ ID(:,1:e-1) [ ID(1,f) ID(2,e) ID(3,f) ]' ID(:,e+1:f-1) ];
  end
  e = find( ID(1,:) == -1, 1, 'first' );
  f = find( ID(1,:) ~= -1, 1, 'last' );
end

ID( :, ID(1,:) == -1 ) = [];
uint64( sum( ID(1,:) .*( ID(2,:).*ID(3,:) + (ID(3,:).*(ID(3,:)-1))/2 ) ) )

%%

ID = [ -ones( 1, LL ) ; cumsum( [ 0 L(1:end-1) ] ) ; L ];
ID( 1, 1:2:end ) = 0:(LL/2-1);

for id = max(ID(1,:)):-1:0

  f = find( ID(1,:) == id, 1, 'first' );
  e = find( ID(1,:) == -1 & ID(3,:) >= ID(3,f), 1, 'first' );
  if isempty( e ) || e > f
    continue
  end

  if ID(3,e) > ID(3,f)
    ID = [ ID(:,1:e-1) [ ID(1,f) ID(2,e) ID(3,f) ]' [ -1 ID(2,e)+ID(3,f) ID(3,e)-ID(3,f) ]' ID(:,e+1:f-1) [ -1 ID(2,f) ID(3,f) ]' ID(:,f+1:end) ];
  else % ID(3,e) == ID(3,l)
    ID = [ ID(:,1:e-1) [ ID(1,f) ID(2,e) ID(3,f) ]' ID(:,e+1:f-1) [ -1 ID(2,f) ID(3,f) ]' ID(:,f+1:end) ];
  end

end

ID( :, ID(1,:) == -1 ) = [];
uint64( sum( ID(1,:) .*( ID(2,:).*ID(3,:) + (ID(3,:).*(ID(3,:)-1))/2 ) ) )
