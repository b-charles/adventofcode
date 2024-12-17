function [ R , P ] = readin( filename )

fid = fopen( filename );

R = { 1, 0, 0, 0 [] };

t = regexp( fgetl( fid ), '(\d+)', 'tokens' );
R{2} = str2double( t{1}{1} );
t = regexp( fgetl( fid ), '(\d+)', 'tokens' );
R{3} = str2double( t{1}{1} );
t = regexp( fgetl( fid ), '(\d+)', 'tokens' );
R{4} = str2double( t{1}{1} );

fgetl( fid );

t = regexp( fgetl( fid ), '(\d+)', 'tokens' );
P = cellfun( @(c)str2double(c{1}), t );

fclose( fid );
