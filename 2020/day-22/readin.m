function [P1, P2] = readin( file )
  
  fid = fopen( file );
  
  function P = read()
    
    P = [];
    
    l = fgetl( fid );
    while ~isempty( l ) && ischar( l )
      P(end+1) = str2double( l ); %#ok<AGROW>
      l = fgetl( fid );
    end
    
  end
  
  fgetl( fid ); % Player 1:
  P1 = read();
  fgetl( fid ); % Player 2:
  P2 = read();
  
  fclose( fid );
  
end