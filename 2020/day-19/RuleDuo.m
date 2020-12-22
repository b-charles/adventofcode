classdef RuleDuo < Rule
  
  properties
    open = 0;
    close = 0;
  end
  
  methods
    
    function rule = RuleDuo( open, close )
      rule.open = open+1;
      rule.close = close+1;
    end
    
    function match = check( self, value, R, rest )
      
      match = false;
      for k = 1:(length(value)-length(rest))/2
        match = Rule.next( value, R, [ repmat( self.open, 1, k ) repmat( self.close, 1, k ) rest ] );
        if match
          return
        end
      end
      
    end
    
  end
  
end