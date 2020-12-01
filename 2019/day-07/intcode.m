function [ out, ask_input] = intcode( codes, in )

  inIndex = 1;

  out = [];
  ask_input = false;

  function value = get( index, arg )
    value = codes( index + arg );
    if( rem( floor( codes(index) / (10^(arg+1)) ), 2 ) == 0 )
      value = codes( value + 1 );
    end
  end

  i = 1;
  while( true )

    if rem( codes(i), 100 ) == 1
      codes( codes(i+3) + 1 ) = get( i, 1 ) + get( i, 2 );
      i = i+4;

    elseif rem( codes(i), 100 ) == 2
      codes( codes(i+3) + 1 ) = get( i, 1 ) * get( i, 2 );
      i = i+4;

    elseif codes(i) == 3
      if( inIndex > length( in ) )
        ask_input = true;
        break;
      end
      codes( codes(i+1) + 1 ) = in(inIndex);
      inIndex = inIndex+1;
      i = i+2;

    elseif rem( codes(i), 100 ) == 4
      out = [out get( i, 1 )];
      i = i+2;

    elseif rem( codes(i), 100 ) == 5
      if get( i, 1 ) ~= 0
        i = get( i, 2 )+1;
      else
        i = i+3;
      end

    elseif rem( codes(i), 100 ) == 6
      if get( i, 1 ) == 0
        i = get( i, 2 )+1;
      else
        i = i+3;
      end

    elseif rem( codes(i), 100 ) == 7
      codes( codes(i+3) + 1 ) = get( i, 1 ) < get( i, 2 );
      i = i+4;

    elseif rem( codes(i), 100 ) == 8
      codes( codes(i+3) + 1 ) = get( i, 1 ) == get( i, 2 );
      i = i+4;

    elseif codes(i) == 99
      break;
    else
      error( 'Unexpected code: %d at %d', codes(i), i )
    end

  end

end
