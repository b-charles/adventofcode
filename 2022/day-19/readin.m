function BP = readin( filename )

BP = zeros( 0, 6 );

fid = fopen( filename );

line = fgetl( fid );
while ischar( line )
  N = regexp( line, 'Blueprint \d+: Each ore robot costs (?<oo>\d+) ore. Each clay robot costs (?<co>\d+) ore. Each obsidian robot costs (?<bo>\d+) ore and (?<bc>\d+) clay. Each geode robot costs (?<go>\d+) ore and (?<gb>\d+) obsidian.', 'names' );
  BP(end+1,:) = [ str2double(N.oo) str2double(N.co) str2double(N.bo) str2double(N.bc) str2double(N.go) str2double(N.gb) ]; %#ok<AGROW>
  line = fgetl( fid );
end

fclose( fid );