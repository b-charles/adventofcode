function [ N, V, OP ] = readin( filename )

N = zeros( 0, 3 );
V = false( 0, 1 );
OP = zeros( 0, 4 );

  function i = recordName( name )

    [ p, i ] = ismember( name, N, 'rows' );
    if p
      return
    end

    N = [ N ; name ];
    V = [ V ; nan ];
    i = size( N, 1 );

  end

fid = fopen( filename );

line = fgetl( fid );
while ~isempty( line )

  n = regexp( line, '(?<name>\w+): (?<value>0|1)', 'names' );
  V( recordName( n.name ) ) = n.value == '1';

  line = fgetl( fid );

end

OP_V = struct( 'AND', 1, 'OR', 2, 'XOR', 3 );

line = fgetl( fid );
while ischar( line )

  n = regexp( line, '(?<op1>\w+) (?<op>AND|OR|XOR) (?<op2>\w+) -> (?<res>\w+)', 'names' );

  op1 = recordName( n.op1 );
  op2 = recordName( n.op2 );
  res = recordName( n.res );
  op = OP_V.( n.op );

  OP = [ OP ; op1 op2 res op ]; %#ok<AGROW> 

  line = fgetl( fid );

end

fclose( fid );

end