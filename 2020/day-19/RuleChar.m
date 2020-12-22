classdef RuleChar < Rule
  
  properties
    char = '';
  end
  
  methods
    
    function rule = RuleChar( char )
      rule.char = char;
    end
    
    function match = check( self, value, R, rest )
      match = ~isempty( value ) && value(1) == self.char && Rule.next( value(2:end), R, rest );
    end
    
  end
  
end