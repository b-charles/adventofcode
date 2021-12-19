
C = readin( 'input.txt' );

s = length( C );

S = struct( ...
  'P', cellfun( @(P) [ P ones(size(P,1),1) ], C, 'UniformOutput', false ), ...
  'D', cellfun( @reldist, C, 'UniformOutput', false ), ...
  'T', [], ...
  'S', [], ...
  'A', [] );

S(1).T = eye(4);
S(1).S = [ 0 0 0 1 ];
S(1).A = S(1).P;

done = [ true false(1,s-1) ];
new = 1;

while any( ~done )

  i = new(1);
  new = new(2:end);

  for j = find( ~done )
    [ e12, p1, p2 ] = overlapping( S(i), S(j) );
    if e12
      S(j).T = getT( S(i), S(j), p1, p2 ) * S(i).T;
      S(j).S = [ 0 0 0 1 ] * S(j).T;
      S(j).A = S(j).P * S(j).T;
      done(j) = true;
      new = [ new j ]; %#ok<AGROW>
    end
  end

end

size( unique( cat( 1, S.A ), 'rows' ), 1 )

%%

N = nchoosek( 1:s, 2 );
D = zeros( 1, size(N,1) );
for i = 1:size(N,1)
  D(i) = sum( abs( S(N(i,1)).S - S(N(i,2)).S ) );
end

max( D )

%%

function D = reldist( P )
s = size( P, 1 );
I = nchoosek( 1:s, 2 );
D = [ I sum( ( P(I(:,1),:) - P(I(:,2),:) ).^2, 2 ) ];
end

function [ e12, p1, p2 ] = overlapping( s1, s2 )

[ V, i1, i2 ] = intersect( s1.D(:,3), s2.D(:,3) );
e12  = length(V) >= 66;
if ~e12
  p1 = []; p2 = [];
  return
end

j1 = s1.D( i1, [1 2] );
p1 = unique( j1(:) );

j2 = s2.D( i2, [1 2] );
p2 = unique( j2(:) );

end

function T = getT( s1, s2, p1, p2 )
persistent R;
if isempty(R)
  R = { ...
    [ -1  0  0 0 ;  0 -1  0 0 ;  0  0  1 0 ; 0 0 0 1 ], ...
    [ -1  0  0 0 ;  0  0 -1 0 ;  0 -1  0 0 ; 0 0 0 1 ], ...
    [ -1  0  0 0 ;  0  0  1 0 ;  0  1  0 0 ; 0 0 0 1 ], ...
    [ -1  0  0 0 ;  0  1  0 0 ;  0  0 -1 0 ; 0 0 0 1 ], ...
    [  0 -1  0 0 ; -1  0  0 0 ;  0  0 -1 0 ; 0 0 0 1 ], ...
    [  0 -1  0 0 ;  0  0 -1 0 ;  1  0  0 0 ; 0 0 0 1 ], ...
    [  0 -1  0 0 ;  0  0  1 0 ; -1  0  0 0 ; 0 0 0 1 ], ...
    [  0 -1  0 0 ;  1  0  0 0 ;  0  0  1 0 ; 0 0 0 1 ], ...
    [  0  0 -1 0 ; -1  0  0 0 ;  0  1  0 0 ; 0 0 0 1 ], ...
    [  0  0 -1 0 ;  0 -1  0 0 ; -1  0  0 0 ; 0 0 0 1 ], ...
    [  0  0 -1 0 ;  0  1  0 0 ;  1  0  0 0 ; 0 0 0 1 ], ...
    [  0  0 -1 0 ;  1  0  0 0 ;  0 -1  0 0 ; 0 0 0 1 ], ...
    [  0  0  1 0 ; -1  0  0 0 ;  0 -1  0 0 ; 0 0 0 1 ], ...
    [  0  0  1 0 ;  0 -1  0 0 ;  1  0  0 0 ; 0 0 0 1 ], ...
    [  0  0  1 0 ;  0  1  0 0 ; -1  0  0 0 ; 0 0 0 1 ], ...
    [  0  0  1 0 ;  1  0  0 0 ;  0  1  0 0 ; 0 0 0 1 ], ...
    [  0  1  0 0 ; -1  0  0 0 ;  0  0  1 0 ; 0 0 0 1 ], ...
    [  0  1  0 0 ;  0  0 -1 0 ; -1  0  0 0 ; 0 0 0 1 ], ...
    [  0  1  0 0 ;  0  0  1 0 ;  1  0  0 0 ; 0 0 0 1 ], ...
    [  0  1  0 0 ;  1  0  0 0 ;  0  0 -1 0 ; 0 0 0 1 ], ...
    [  1  0  0 0 ;  0 -1  0 0 ;  0  0 -1 0 ; 0 0 0 1 ], ...
    [  1  0  0 0 ;  0  0 -1 0 ;  0  1  0 0 ; 0 0 0 1 ], ...
    [  1  0  0 0 ;  0  0  1 0 ;  0 -1  0 0 ; 0 0 0 1 ], ...
    [  1  0  0 0 ;  0  1  0 0 ;  0  0  1 0 ; 0 0 0 1 ] };
end

P1 = s1.P(p1,:); P2 = s2.P(p2,:);
B1 = mean( P1, 1 ); B2 = mean( P2, 1 );

C1 = round( ( P1 - repmat( B1 - [ 0 0 0 1 ], length(p1), 1 ) )*100 );
C2 = round( ( P2 - repmat( B2 - [ 0 0 0 1 ], length(p2), 1 ) )*100 );

for i = 1:length(R)
  if isempty( setdiff( C1, C2*R{i}, 'rows' ) )
    break
  end
end

r = R{i};
T = r + [ zeros(3,4) ; round( B1 - B2*r ) ];

end