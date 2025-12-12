function [ N, M ] = readin( filename )

S = struct( 'out', [] );

fid = fopen( filename );

pat = asManyOfPattern( characterListPattern( "a", "z" ), 1 );

line = fgetl( fid );
while ischar( line )

  n = extract( line, pat );
  S.( n{1} ) = n(2:end);

  line = fgetl( fid );

end

fclose( fid );

names = fieldnames( S );
n = length( names );

N = struct();
M = false( n, n );

for i = 1:n

  N.( names{i} ) = i;

  O = S.( names{i} );
  for j = 1:length( O )
    M( i, find( cellfun( @(n) strcmp( n, O{j} ), names ), 1 ) ) = true;
  end

end
