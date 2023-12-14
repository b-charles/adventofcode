
G = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
R = G == 'O';
C = G == '#';

(size(G,2):-1:1) * sum( north( R, C ), 2 ) %#ok<NOPTS>

%%

P = { R, cycle( R, C ) };
l = [];
while isempty( l )
  P{end+1} = cycle( P{end}, C ); %#ok<SAGROW>
  l = find( cellfun( @(p) all( p(:) == P{end}(:) ), P(1:end-1) ), 1 );
end

(size(G,2):-1:1) * sum( P{ mod(1000000000-l+1, length(P)-l) + l }, 2 ) %#ok<NOPTS>

%%

function R = north( R, C )

for i = 2:size(R,1)
  I = R(i,:);
  for j = i-1:-1:1
    I = I & ~R(j,:) & ~C(j,:);
    if isempty( I )
      return
    end
    R(j+1,I) = false;
    R(j,I) = true;
  end
end

end

function R = cycle( R, C )
R = north( R, C );
R = rot90( north( rot90( R, -1 ), rot90( C, -1 ) ), 1 );
R = flip( north( flip( R, 1 ), flip( C, 1 ) ), 1 );
R = rot90( north( rot90( R, 1 ), rot90( C, 1 ) ), -1 );
end