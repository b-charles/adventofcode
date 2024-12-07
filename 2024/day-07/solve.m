
C = readin( 'input.txt' );

uint64( sum( [ C( arrayfun( @(c) any( c.test == allcomb1( c.values ) ), C ) ).test ] ) )

%%

uint64( sum( [ C( arrayfun( @(c) any( c.test == allcomb2( c.values ) ), C ) ).test ] ) )

%%

function R = allcomb1( values )
R = values(1);
for v = values(2:end)
  R = [ R+v ; R*v ];
end
end

function R = allcomb2( values )
R = values(1);
for v = values(2:end)
  R = [ R+v ; R*v ; R*10^(floor(log10(v))+1)+v ];
end
end
