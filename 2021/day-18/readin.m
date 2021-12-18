function P = readin( lines )

if isfile( lines )
  lines = readlines( lines, 'EmptyLineRule', 'skip' );
end
P = arrayfun( @(l)readline(char(l),1), lines );

  function [ p, idx ] = readline( line, idx )

    c = line(idx);

    if '0' <= c && c <= '9'
      p = Pair( c - '0' );
    elseif c == '['
      [ p1, idx ] = readline( line, idx+1 );
      [ p2, idx ] = readline( line, idx+1 );
      p = Pair( p1, p2 );
    end
    idx = idx + 1;

  end

end