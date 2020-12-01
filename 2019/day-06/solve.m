
clear all
clc

% in = sprintf('COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L');
in = 'obj.in';

O = readin( in )

%%

sum( O.getOrbits() )

%%

YOU = Obj.getByName( 'YOU' );
SAN = Obj.getByName( 'SAN' );

PY = YOU.allParents();
PS = SAN.allParents();

n = length( PY ) + length( PS );

i = 1;
while( PY(i).name == PS(i).name )
  n = n - 2;
  i = i + 1;
end

n

