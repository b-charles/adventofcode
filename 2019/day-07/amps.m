function O5 = amps( data, inputs )
  O1 = intcode( data, [ inputs( 1 ) 0  ] );
  O2 = intcode( data, [ inputs( 2 ) O1 ] );
  O3 = intcode( data, [ inputs( 3 ) O2 ] );
  O4 = intcode( data, [ inputs( 4 ) O3 ] );
  O5 = intcode( data, [ inputs( 5 ) O4 ] );
end
