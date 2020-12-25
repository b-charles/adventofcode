
% C = ( '389125467' - '0' );
C = ( '598162734' - '0' );

N1(C) = [ C(2:end) C(1) ];
N1 = bonneteau( N1, C(1), 100 );

Z = 1;
for k = 2:length(C)
  Z(end+1) = N1( Z(end) ); %#ok<SAGROW>
end

disp( sprintf( '%d', Z(2:end) ) ); %#ok<DSPS>

%%

C2 = [ C length(C)+1:1000000 ];

N2(C2) = [ C2(2:end) C2(1) ];
N2 = bonneteau( N2, C2(1), 10000000 );

disp( uint64( N2(1) * N2(N2(1)) ) );

%%

function N = bonneteau( N, pc, num )
  
  n = length(N);
  m = @(i)mod(i-1,n)+1;
  
  for k = 1:num
    
    pc1 = N(pc);
    pc2 = N(pc1);
    pc3 = N(pc2);
    
    pt = m(pc-1);
    while pt==pc1 || pt==pc2 || pt==pc3
      pt = m(pt-1);
    end
    
    [ N(pc), N(pt), N(pc3) ] = deal( N(pc3), pc1, N(pt) );
    pc = N(pc);
    
  end
  
end
