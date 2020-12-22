classdef RuleOr < Rule
  
  properties
    seqs = {};
  end
  
  methods
    
    function rule = RuleOr( seqs )
      rule.seqs = seqs;
    end
    
    function match = check( self, value, R, rest )
      for k = 1:length( self.seqs )
        match = self.seqs{k}.check( value, R, rest );
        if match
          return
        end
      end
    end
    
  end
  
end
