function l = shortest( H, S, E )

[ si, sj ] = size(H);

B = cat( 3, ...
  false( si, sj ), ...
  H - [ H(2:end,:) ; inf(1,sj) ] > 1, ...
  H - [ inf(1,sj) ; H(1:end-1,:) ] > 1, ...
  H - [ inf(si,1) H(:,1:end-1) ] > 1, ...
  H - [ H(:,2:end) inf(si,1) ] > 1 );

P = inf( si, sj, 5 );
P(S) = 0;

while isinf( P(E) )

  P(:,:,2) = [ P(2:end,:,1) ; inf(1,sj) ] + 1;
  P(:,:,3) = [ inf(1,sj) ; P(1:end-1,:,1) ] + 1;
  P(:,:,4) = [ inf(si,1) P(:,1:end-1,1) ] + 1;
  P(:,:,5) = [ P(:,2:end,1) inf(si,1) ] + 1;

  P(B) = Inf;

  P(:,:,1) = min( P, [], 3 );

end

l = P(E);
