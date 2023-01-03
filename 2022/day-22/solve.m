
[ M, P ] = readin( 'input.txt' );

run( M, P, @(S) part1( M, S ) )

%%

U = zeros( 50, 50 );
run( M, P, @(S) part2( M, [ U U+1 U+2 ; U U+3 U ; U+4 U+5 U ; U+6 U U ], S ) )

%%

function S = part1( M, S )
i = S(1); j = S(2); d = S(3);
if d == 0
  j = j+1;
  if j > size(M,2) || M(i,j) == -1
    j = find( M(i,:) ~= -1, 1 );
  end
elseif d == 1
  i = i+1;
  if i > size(M,1) || M(i,j) == -1
    i = find( M(:,j) ~= -1, 1 );
  end
elseif d == 2
  j = j-1;
  if j < 1 || M(i,j) == -1
    j = find( M(i,:) ~= -1, 1, 'last' );
  end
elseif d == 3
  i = i-1;
  if i < 1 || M(i,j) == -1
    i = find( M(:,j) ~= -1, 1, 'last' );
  end
end
S = [ i j d ]';
end

function S = part2( M, F, S )
i = S(1); j = S(2); d = S(3); f = F(i,j);
if d == 0
  j = j+1;
  if j > size(M,2) || F(i,j) ~= f
    if f == 1
      %
    elseif f == 2
      [ i, j, d ] = deal( 151 - i, 100, 2 );
    elseif f == 3
      [ i, j, d ] = deal( 50, i + 50, 3 );
    elseif f == 4
      %
    elseif f == 5
      [ i, j, d ] = deal( 151 - i, 150, 2 );
    else % f == 6
      [ i, j , d ] = deal( 150, i - 100, 3 );
    end
  end
elseif d == 1
  i = i+1;
  if i > size(M,1) || F(i,j) ~= f
    if f == 1
      %
    elseif f == 2
      [ i, j, d ] = deal( j - 50, 100, 2 );
    elseif f == 3
      %
    elseif f == 4
      %
    elseif f == 5
      [ i, j, d ] = deal( j + 100, 50, 2 );
    else % f == 6
      [ i, j, d ] = deal( 1, j + 100, 1 );
    end
  end
elseif d == 2
  j = j-1;
  if j < 1 || F(i,j) ~= f
    if f == 1
      [ i, j, d ] = deal( 151 - i, 1, 0 );
    elseif f == 2
      %
    elseif f == 3
      [ i, j, d ] = deal( 101, i - 50, 1 );
    elseif f == 4
      [ i, j, d ] = deal( 151 - i, 51, 0 );
    elseif f == 5
      %
    else % f == 6
      [ i, j, d ] = deal( 1, i - 100, 1 );
    end
  end
elseif d == 3
  i = i-1;
  if i < 1 || F(i,j) ~= f
    if f == 1
      [ i, j, d ] = deal( j + 100, 1, 0 );
    elseif f == 2
      [ i, j, d ] = deal( 200, j - 100 , 3 );
    elseif f == 3
      %
    elseif f == 4
      [ i, j, d ] = deal( j + 50, 51, 0 );
    elseif f == 5
      %
    else % f == 6
      %
    end
  end
end
S = [ i j d ]';
end

function R = run( M, P, next )

S = [ 1, find( M(1,:)==0, 1 ), 0 ]';
for i = 1:size(P,2)
  for k = 1:P(1,i)
    T = next( S );
    if M( T(1), T(2) ) == 1
      break
    else
      S = T;
    end
  end
  S(3) = mod( S(3) + P(2,i), 4 );
end

R = [ 1000 4 1 ] * S;

end