classdef RuleSeq < Rule
  
  properties
    seq = [];
  end
  
  methods
    
    function rule = RuleSeq( seq )
      rule.seq = seq+1;
    end
    
    function match = check( self, value, R, rest )
      match = Rule.next( value, R, [ self.seq rest ] );
    end
    
  end
  
end