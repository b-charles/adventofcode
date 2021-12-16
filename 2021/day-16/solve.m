
p = Packet.read( strtrim( fileread( 'input.txt' ) ) );

p.sumVersion()

%%

uint64( p.compute() )
