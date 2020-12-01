function [ codes, out, ask_input ] = intcode( codes, in )

  codes = int64(codes);

  inIndex = 1;

  out = [];
  ask_input = false;

  base = 0;

  function m = mode( index, arg )
    m = rem( floor( codes(index) / (10^(arg+1)) ), 10 );
  end

  function value = get( index, arg )

    function v = safeget( index )
      if( index > length( codes ) )
        codes( index ) = 0;
      end
      v = codes( index );
    end

    m = mode( index, arg );

    value = safeget( index + arg );
    if( m == 0 )
      value = safeget( value + 1 );
    elseif( m == 2 )
      value = safeget( base + value + 1 );
    end

  end

  function set( index, arg, value )
    m = mode( index, arg );

    varg = codes( index + arg ) + 1;
    if( m == 0 )
      codes( varg ) = value;
    elseif( m == 1 )
      error( 'Can not assign to constant.' );
    elseif( m == 2 )
      codes( base + varg ) = value;
    end
  end

  i = 1;
  while( true )

    code = rem( codes(i), 100 );

    if code == 1
      set( i, 3, get( i, 1 ) + get( i, 2 ) );
      i = i+4;

    elseif code == 2
      set( i, 3, get( i, 1 ) * get( i, 2 ) );
      i = i+4;

    elseif code == 3
      if( inIndex > length( in ) )
        ask_input = true;
        break;
      end
      set( i, 1, in(inIndex) );
      inIndex = inIndex+1;
      i = i+2;

    elseif code == 4
      out = [out get( i, 1 )];
      i = i+2;

    elseif code == 5
      if get( i, 1 ) ~= 0
        i = get( i, 2 )+1;
      else
        i = i+3;
      end

    elseif code == 6
      if get( i, 1 ) == 0
        i = get( i, 2 )+1;
      else
        i = i+3;
      end

    elseif code == 7
      set( i, 3, get( i, 1 ) < get( i, 2 ) );
      i = i+4;

    elseif code == 8
      set( i, 3, get( i, 1 ) == get( i, 2 ) );
      i = i+4;

    elseif code == 9
      base = base + get( i, 1 );
      i = i+2;

    elseif code == 99
      break;
    else
      error( 'Unexpected code: %d at %d', codes(i), i )
    end

  end

end
