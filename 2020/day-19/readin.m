function [ rules, messages ] = readin( file )
  
  fid = fopen( file );
  
  %% Rules
  
  rules = {};
  
  l = fgetl( fid );
  while ~isempty( l )
    
    T = regexp( l, '(\d+): "(\w+)"', 'tokens' );
    if ~isempty( T )
      
      rules{ str2double(T{1}{1})+1 } = RuleChar(T{1}{2}); %#ok<AGROW>
      
    else
      
      s1 = split( l, ':' );
      index = str2double( s1{1} );
      
      S2 = split( s1{2}, '|' );
      
      n = length( S2 );
      R = cell( 1, n );
      for i = 1:n
        R{i} = RuleSeq( cellfun( @str2double, regexp( S2{i}, '(\d+)', 'tokens' ) ) );
      end
      
      if n == 1
        rules{ index+1 } = R{1}; %#ok<AGROW>
      else
        rules{ index+1 } = RuleOr( R ); %#ok<AGROW>
      end
      
    end
    
    l = fgetl( fid );
    
  end
  
  %% Messages
  
  messages = {};
  
  l = fgetl( fid );
  while ischar( l )
    
    messages{end+1} = l; %#ok<AGROW>
    
    l = fgetl( fid );
    
  end
  
end