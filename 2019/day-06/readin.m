function A = readin( in )

  objs = [];

  if isfile( in )
    in = fileread( in );
  end

  C = regexp( in, '(\w+)\)(\w+)', 'tokens' );

  N = length( C );
  A = Obj.empty( 2, 0 );
  for i = 1:N
    
    c = Obj.getByName( C{i}{1} );
    s = Obj.getByName( C{i}{2} );

    c.addSat( s );

    A(:,i) = [c; s];

  end

  A = unique( A(:) );

end
