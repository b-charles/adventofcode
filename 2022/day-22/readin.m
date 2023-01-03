function [ M, P ] = fileread( filename )

fid = fopen( filename );

M = [];
K( ' .#' ) = [ -1 0 1 ];
line = fgetl( fid );
while ~isempty( line )
  M(end+1,:) = K( pad( line, size(M,2) ) ); %#ok<AGROW>
  line = fgetl( fid );
end

line = fgetl( fid );

T = regexp( line, '\d+|(L|R)', 'match' );
P(1,:) = str2double( T(1:2:end) );
K( 'LRE' ) = [ -1 1 0 ];
P(2,:) = K( [ cell2mat( T(2:2:end) ) 'E' ] );

fclose( fid );
