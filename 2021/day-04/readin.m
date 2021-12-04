function [T, C] = readin( file )

fid = fopen( file );

T = str2num( fgetl( fid ) ); %#ok<ST2NM>

N = fscanf( fid, '%f' );
C = mat2cell( reshape( N, 5, [] ), 5, repmat( 5, 1, size(N,1) / 25 ) );

fclose( fid );
