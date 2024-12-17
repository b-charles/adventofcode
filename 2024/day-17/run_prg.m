function R = run_prg( R, P )
clc;

f = size( P, 2 );

  function v = combo(v)
    if v == 4
      v = R{2};
    elseif v == 5
      v = R{3};
    elseif v == 6
      v = R{4};
    end
  end

while R{1} <= f

  op = P( 1, R{1} );
  v = P( 2, R{1} );

  if op == 0
    R{2} = floor( R{2} / 2^combo(v) );
  elseif op == 1
    R{3} = bitxor( R{3}, v );
  elseif op == 2
    R{3} = mod( combo(v), 8 );
  elseif op == 3
    if R{2} ~=0
      R{1} = v/2;
    end
  elseif op == 4
    R{3} = bitxor( R{3}, R{4} );
  elseif op == 5
    R{5} = [ R{5} mod(combo(v), 8) ];
  elseif op == 6
    R{3} = floor( R{2} / 2^combo(v) );
  else % op == 7
    fprintf( '%d / %d = %d\n', R{2}, combo(v), floor( R{2} / 2^combo(v) ) );
    R{4} = floor( R{2} / 2^combo(v) );
  end

  R{1} = R{1} + 1;

end

end