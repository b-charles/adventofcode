function [f, F, T, N ] = readin( file )

  fid = fopen( file );
  
  %% field ranges
  
  f = struct();
  F = zeros( 0, 4 );
  
  l = fgetl( fid );
  while ~isempty( l )
    
    tok = regexp( l, '([\w\s]+): (\d+)-(\d+) or (\d+)-(\d+)', 'tokens' );
    
    F(end+1,:) = [ str2double(tok{1}{2}) str2double(tok{1}{3}) str2double(tok{1}{4}) str2double(tok{1}{5}) ];
    f.( replace( tok{1}{1}, ' ', '_' ) ) = size( F, 1 );
    
    l = fgetl( fid );
    
  end
  
  %% your ticket
  
  fgetl( fid ); % your tiket:
  T = cellfun( @(t) str2double( t{1} ), regexp( fgetl( fid ), '(\w+)', 'tokens' ) );
  fgetl( fid ); % empty
  
  %% nearby tickets
  
  fgetl( fid ); % nearby tickets:
  
  N = [];
  
  l = fgetl( fid );
  while ischar( l )
    N(end+1,:) = cellfun( @(t) str2double( t{1} ), regexp( l, '(\w+)', 'tokens' ) );
    l = fgetl( fid );
  end
  
  fclose( fid );

end