
P = readin( 'input.txt' );

sum( find( arrayfun( @(i)comp(P{1,i}, P{2,i}), 1:size(P,2) ) > 0 ) )

%%

( sum( cellfun( @(c)comp(c,{{2}}), P(:) ) > 0 ) + 1 ) * ...
  ( sum( cellfun( @(c)comp(c,{{6}}), P(:) ) > 0 ) + 2 )

%%

function o = comp( A, B )
i = 1;
while i <= length(A) && i <= length(B)
  a = A{i}; b = B{i};
  na = isnumeric(A{i});
  nb = isnumeric(B{i});
  if na && nb
    o = sign( b - a );
  elseif ~na && ~nb
    o = comp( a, b );
  elseif na && ~nb
    o = comp( {a}, b );
  else % ~na && nb
    o = comp( a, {b} );
  end
  if o ~= 0
    return
  end
  i = i + 1;
end
o = sign( length(B) - length(A) );
end