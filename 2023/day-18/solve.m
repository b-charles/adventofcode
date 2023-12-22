
F = readlines( 'input.txt', 'EmptyLineRule', 'skip' );

S = cell2mat( regexp( F, '(?<dir1>[UDLR]) (?<len1>\d+) \(#(?<len2>[0-9a-f]{5})(?<dir2>[0123])\)', 'names' ) );

D1( 'RDLU' ) = 1:4;
lagoon( D1( char( join( [ S.dir1 ], '' ) ) ), str2double( [ S.len1 ] ) )

%%

uint64( lagoon( str2double( [ S.dir2 ] ) + 1, hex2dec( [ S.len2 ] ) ) )
