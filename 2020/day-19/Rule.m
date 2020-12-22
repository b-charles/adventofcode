classdef Rule < handle
  
  methods( Static )
    
    function match = next( value, R, rest )
      
      if isempty( rest )
        match = isempty( value );
      else
        match = R{rest(1)}.check( value, R, rest(2:end) );
      end
      
    end
    
  end
  
end