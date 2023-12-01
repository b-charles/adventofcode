
L = readlines('input', 'EmptyLineRule', 'skip');

sum( str2num( [ arrayfun( @(l)regexprep(char(l), '[a-z]*([0-9]).*', '$1'), L ) arrayfun( @(l)regexprep(char(l), '.*([0-9])[a-z]*', '$1'), L ) ] ) ) %#ok<ST2NM> 

%%

S = replace( replace( replace( replace( replace( replace( replace( replace( replace( L, 'one', 'o1e'), 'two', 't2o' ), 'three', 't3e' ), 'four', 'f4r' ), 'five', 'f5e' ), 'six', 's6x' ), 'seven', 's7e' ), 'eight', 'e8t' ), 'nine', 'n9e' );
sum( str2num( [ arrayfun( @(l)regexprep(char(l), '[a-z]*([0-9]).*', '$1'), S ) arrayfun( @(l)regexprep(char(l), '.*([0-9])[a-z]*', '$1'), S ) ] ) ) %#ok<ST2NM> 
