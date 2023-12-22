function t = lagoon( D, L )
% D: R:1 D:2 L:3 U:4
%#ok<*AGROW>

N = length( D );

H = zeros( 0, 4 ); % i, jmin, jmax, isSep
V = zeros( 0, 3 ); % imin, imax, j

C = [0 0];
for i = 1:N

  if D(i) == 1
    H = [ H ; C(1) C(2) C(2)+L(i) D( mod(i-2,N)+1 )==D( mod(i,N)+1 ) ];
    C = [ C(1) C(2)+L(i) ];
  elseif D(i) == 2
    V = [ V ; C(1)+1 C(1)+L(i)-1 C(2) ];
    C = [ C(1)+L(i) C(2) ];
  elseif D(i) == 3
    H = [ H ; C(1) C(2)-L(i) C(2) D( mod(i-2,N)+1 )==D( mod(i,N)+1 ) ];
    C = [ C(1) C(2)-L(i) ];
  else % D(i) == 4
    V = [ V ; C(1)-L(i)+1 C(1)-1 C(2) ];
    C = [ C(1)-L(i) C(2) ];
  end

end

  function [ j, t, in ] = horz( j, t, in, jmin, jmax, sep )
    t = t + in*( jmin - j ) + jmax - jmin + 1;
    j = jmax + 1;
    in = xor( in, sep );
  end

  function [ j, t, in ] = vert( j, t, in, jval )
    t = t + in*( jval - j ) + 1;
    j = jval + 1;
    in = ~in;
  end

imin = min( H(:,1) );
imax = max( H(:,1) );
jmin = min( V(:,3) ) - 1;

t = 0;
for i = imin:imax

  F = {};
  J = [];

  for l = find( H(:,1) == i )'
    F{end+1} = @(j,t,in) horz( j, t, in, H(l,2), H(l,3), H(l,4)>0 );
    J(end+1) = H(l,2);
  end
  for l = find( V(:,1) <= i & i <= V(:,2) )'
    F{end+1} = @(j,t,in) vert( j, t, in, V(l,3) );
    J(end+1) = V(l,3);
  end

  [ ~, I ] = sort( J );
  F = F(I);

  j = jmin;
  in = false;
  for l = 1:length( F )
    [ j, t, in ] = F{l}( j, t, in );
  end

end

end