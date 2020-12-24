
% [ P1, P2 ] = deal( [ 9 2 6 3 1 ], [ 5 8 4 7 10 ] );
[ P1, P2 ] = readin( 'data.in' );

score = @(P) P * (length(P):-1:1)';

[ Q1, Q2 ] = deal( P1, P2 );
while ~isempty( Q1 ) && ~isempty( Q2 )
  [ Q1, Q2 ] = winner( Q1(1) > Q2(1), Q1, Q2 );
end

disp( score(Q1) + score(Q2) );

%%

[R1, R2] = game2( P1, P2 );
disp( score(R1) + score(R2) );

%%

function [ P1, P2 ] = winner( p1winner, P1, P2 )
  if p1winner
    P1 = [ P1(2:end) P1(1) P2(1) ]; P2 = P2(2:end);
  else
    P2 = [ P2(2:end) P2(1) P1(1) ]; P1 = P1(2:end);
  end
end

function [ P1, P2, p1winner ] = game2( P1, P2 )
  
  B = zeros( 2500, 1+length(P1)+length(P2) );
  
  H = B; H(1,:) = [ length(P1) P1 P2 ];
  r = 2;
  
  while ~isempty( P1 ) && ~isempty( P2 )
    
    if P1(1)<length(P1) && P2(1)<length(P2)
      [ ~, ~, p1winner ] = game2( P1(2:1+P1(1)), P2(2:1+P2(1)) );
      [ P1, P2 ] = winner( p1winner, P1, P2 );
    else
      [ P1, P2 ] = winner( P1(1) > P2(1), P1, P2 );
    end
    
    h = [ length(P1) P1 P2 ];
    
    if r > size(H,1)
      H = [ H ; B ]; %#ok<AGROW>
      if ismember( h, H, 'rows' )
        p1winner = true;
        return
      end
    end
    
    H(r,:) = h;
    
    r = r + 1;
    
  end
  
  p1winner = length(P1) > length(P2);
  
end
