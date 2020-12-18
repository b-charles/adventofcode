
lines = cellfun( @(l) replace( l, ' ', '' ), splitlines( fileread( 'data.in' ) ), 'UniformOutput', false );

disp( uint64( sum( double( cellfun( @(l)eval1(l,1), lines ) ) ) ) );

%%

disp( uint64( sum( double( cellfun( @(l)eval2(l,1), lines ) ) ) ) );

%%

function [ A, s ] = eval1( line, s )
  
  [ A, O, s ] = parseExpr( @eval1, line, s );
  
  while length( A ) > 1
    [ A, O ] = aggregate( A, O, 1 );
  end
  
end

function [ A, s ] = eval2( line, s )
  
  [ A, O, s ] = parseExpr( @eval2, line, s );
  
  while contains( O, '+' )
    [ A, O ] = aggregate( A, O, find( O == '+', 1 ) );
  end
  while length( A ) > 1
    [ A, O ] = aggregate( A, O, 1 );
  end
  
end

function [ A, O, s ] = parseExpr( evalFnc, line, s )
  
  O = '';
  
  [ A, s ] = evalArg( evalFnc, line, s );
  while s <= length( line ) && line(s) ~= ')'
    O(end+1) = line(s); %#ok<AGROW>
    [ A(end+1), s ] = evalArg( evalFnc, line, s+1 ); %#ok<AGROW>
  end
  
  s = s + 1;
  
end

function [ A, O ] = aggregate( A, O, i )
  if O(i) == '+'
    v = A(i) + A(i+1);
  else
    v = A(i) * A(i+1);
  end
  [ A, O ] = deal( [ A(1:i-1) v A(i+2:end) ], [ O(1:i-1) O(i+1:end) ] );
end

function [ val, s ] = evalArg( evalFnc, line, s )
  if line(s) == '('
    [ val, s ] = evalFnc( line, s+1 );
  else
    [ val, s ] = deal( str2double( line(s) ), s+1 );
  end
end
