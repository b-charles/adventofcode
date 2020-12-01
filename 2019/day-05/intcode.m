function out = intcode( codes, in )

  out = [];

  function [ value, str ] = get( index, arg )
    value = codes( index + arg );
    str = sprintf( '%d', value );
    if( rem( floor( codes(index) / (10^(arg+1)) ), 2 ) == 0 )
      str = sprintf( '*%d(%d)', value, codes( value + 1 ) );
      value = codes( value + 1 );
    end
  end

  i = 1;
  while( true )

    if rem( codes(i), 100 ) == 1

      [ arg1, str1 ] = get( i, 1 );
      [ arg2, str2 ] = get( i, 2 );

      ri = codes(i+3) + 1;
      r = arg1 + arg2;
      fprintf( '[ %4d %5d %5d %5d ] => @%d(%d) = %s + %s = %d\n', codes([ i i+1 i+2 i+3 ]), ri, codes(ri), str1, str2, r );

      codes( ri ) = r;
      i = i+4;

    elseif rem( codes(i), 100 ) == 2

      [ arg1, str1 ] = get( i, 1 );
      [ arg2, str2 ] = get( i, 2 );

      ri = codes(i+3) + 1;
      r = arg1 * arg2;
      fprintf( '[ %4d %5d %5d %5d ] => @%d(%d) = %s * %s = %d\n', codes([ i i+1 i+2 i+3 ]), ri, codes(ri), str1, str2, r );

      codes( ri ) = r;
      i = i+4;

    elseif codes(i) == 3

      ri = codes(i+1) + 1;
      fprintf( '[ %4d %5d ]             => @%d(%d) = %d\n', codes([ i i+1 ]), ri, codes(ri), in );

      codes( ri ) = in;
      i = i+2;

    elseif rem( codes(i), 100 ) == 4

      [ arg1, str1 ] = get( i, 1 );
      fprintf( '[ %4d %5d ]             => OUT %s\n', codes([ i i+1 ]), str1 );

      out = [out arg1];
      i = i+2;

    elseif rem( codes(i), 100 ) == 5

      [ arg1, str1 ] = get( i, 1 );
      [ arg2, str2 ] = get( i, 2 );

      r = i+3;
      if arg1 ~= 0
        r = arg2+1;
      end
      fprintf( '[ %4d %5d %5d ]       => JUMP %s ? %s -> %d\n', codes([ i i+1 i+2 ]), str1, str2, r );

      i = r;

    elseif rem( codes(i), 100 ) == 6

      [ arg1, str1 ] = get( i, 1 );
      [ arg2, str2 ] = get( i, 2 );

      r = i+3;
      if arg1 == 0
        r = arg2+1;
      end
      fprintf( '[ %4d %5d %5d ]       => JUMP !%s ? %s -> %d\n', codes([ i i+1 i+2 ]), str1, str2, r );

      i = r;

    elseif rem( codes(i), 100 ) == 7

      [ arg1, str1 ] = get( i, 1 );
      [ arg2, str2 ] = get( i, 2 );

      ri = codes(i+3) + 1;
      r = arg1 < arg2;
      fprintf( '[ %4d %5d %5d %5d ] => @%d(%d) = %s < %s = %d\n', codes([ i i+1 i+2 i+3 ]), ri, codes(ri), str1, str2, r );

      codes( ri ) = r;
      i = i+4;

    elseif rem( codes(i), 100 ) == 8

      [ arg1, str1 ] = get( i, 1 );
      [ arg2, str2 ] = get( i, 2 );

      ri = codes(i+3) + 1;
      r = arg1 == arg2;
      fprintf( '[ %4d %5d %5d %5d ] => @%d(%d) = %s == %s = %d\n', codes([ i i+1 i+2 i+3 ]), ri, codes(ri), str1, str2, r );

      codes( ri ) = r;
      i = i+4;

    elseif codes(i) == 99
      break;
    else
      error( 'Unexpected code: %d at %d', codes(i), i )
    end

  end

end
