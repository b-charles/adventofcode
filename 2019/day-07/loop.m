function out = loops( data, inputs )

  I = cell( 1, 5 );
  I{1} = [ 0 ];

  finished = false;

  function ask = run( i )
    [O, ask] = intcode( data, [ inputs(i) I{i} ] );
    if i < 5
      I{i+1} = O;
    else
      I{1} = [ 0 O ];
    end
  end

  while( ~finished )

    run( 1 );
    run( 2 );
    run( 3 );
    run( 4 );
    finished = ~run( 5 );

  end

  out = I{1}(end);

end
