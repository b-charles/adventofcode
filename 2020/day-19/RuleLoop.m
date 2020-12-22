classdef RuleLoop < Rule
  
  properties
    loop = 0;
  end
  
  methods
    
    function rule = RuleLoop( loop )
      rule.loop = loop+1;
    end
    
    function match = check( self, value, R, rest )
      
      match = false;
      for k = 1:length(value)-length(rest)
        match = Rule.next( value, R, [ repmat( self.loop, 1, k ) rest ] );
        if match
          return
        end
      end
      
    end
    
  end
  
end