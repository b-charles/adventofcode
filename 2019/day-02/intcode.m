function res = intcode( codes )

i = 1;
while( true )

  if( codes(i) == 1 )
    codes( codes(i+3) + 1 ) = codes( codes(i+1) + 1 ) + codes( codes(i+2) + 1 );
  elseif( codes(i) == 2 )
    codes( codes(i+3) + 1 ) = codes( codes(i+1) + 1 ) * codes( codes(i+2) + 1 );
  elseif( codes(i) == 99 )
    break;
  else
    error( 'Unexpected code: %d at %d', codes(i), i )
  end

  i = i+4;

end

res = codes(1);

