
M = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) - '0';

mindist( M )

%%

Z = zeros( size(M) );
L = [ ...
  Z+0 Z+1 Z+2 Z+3 Z+4
  Z+1 Z+2 Z+3 Z+4 Z+5
  Z+2 Z+3 Z+4 Z+5 Z+6
  Z+3 Z+4 Z+5 Z+6 Z+7
  Z+4 Z+5 Z+6 Z+7 Z+8 ];
M = mod( repmat(M,5) + L - 1, 9 ) + 1;

mindist( M )

%%

function d = mindist( M )
  
  sM = size(M);
  
  H = Inf( 1, sM(2) );
  V = Inf( sM(1), 1 );
  
  D = Inf( sM );
  Dp = zeros( sM );
  
  D(1,1) = 0;
  while any( D(:) ~= Dp(:) )
    Dp = D;
    D = M + min( cat( 3, [H;D(1:end-1,:)], [D(:,2:end) V],[D(2:end,:);H], [V D(:,1:end-1)] ), [], 3 );
    D(1,1) = 0;
  end
  
  d = D(end:end);
  
end
