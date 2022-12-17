
DATA = readmatrix( 'input.txt', 'Delimiter', { 'Sensor at x=', ', y=', ': closest beacon is at x=' }, 'LeadingDelimitersRule', 'ignore' );

P = DATA(:, [1 2]);
D = abs( DATA(:,1) - DATA(:,3) ) + abs( DATA(:,2) - DATA(:,4) );

S = [ P(:,1) D-abs( P(:,2) - 2000000 ) ] * [ 1 1 ; -1 1 ];
S( S(:,1) > S(:,2), : ) = [];

length( setdiff( unique( cell2mat( arrayfun( @(i)S(i,1):S(i,2), 1:size(S,1), 'UniformOutput', false ) ) ), DATA( DATA(:,4) == dt, 3 ) ) )

%%

for i = 1:size(P,1)
  u = [ D(i)+1:-1:-D(i) -D(i)-1:D(i) ]';
  T = [ P(i,1)+u P(i,2)+circshift(u,-D(i)-1) ];
  T( T(:,1)<0 | T(:,1)>4000000 | T(:,2)<0 | T(:,2)>4000000, : ) = [];
  for j = 1:size(P,1)
    T( abs(P(j,1)-T(:,1)) + abs(P(j,2)-T(:,2)) <= D(j), : ) = [];
  end
  if size(T,1) > 0
    break
  end
end

uint64( T(1)*4000000 + T(2) )
