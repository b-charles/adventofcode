function [ w, P ] = blink( s, n, P )

while true

  if n == 0
    w = 1;
    return
  elseif s == 0
    s = 1;
    n = n-1;
  elseif s <= size(P,1) && n <= size(P,2) && P(s,n) ~= -1
    w = P(s,n);
    return
  elseif mod( floor( log10(s) ), 2 ) == 1
    b = 10^( ( floor( log10(s) ) + 1 )/2 );
    s1 = floor( s / b );
    s2 = mod( s, b );
    [ w1, P ] = blink( s1, n-1, P );
    [ w2, P ] = blink( s2, n-1, P );
    w = w1 + w2;
    if s <= size(P,1) && n <= size(P,2)
      P(s,n) = w;
    end
    return
  else
    s = s * 2024;
    n = n-1;
  end

end
