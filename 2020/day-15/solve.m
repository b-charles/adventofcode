
% S = [0,3,6];
% S = [1,3,2];
% S = [2,1,3];
% S = [1,2,3];
% S = [2,3,1];
% S = [3,2,1];
% S = [3,1,2];
S = [16,12,1,0,15,7,11];

disp( play( S, 2020 ) );

%%

disp( play( S, 30000000 ) );

function c = play( S, g )
  M = zeros( 1, 100000000 );
  [ M(S+1), c, i ] = deal( 1:length(S), 0, length(S)+1 );
  while i < g
    [ M(c+1), c, i ] = deal( i, (M(c+1)~=0) * (i - M(c+1)), i+1 );
  end
end
