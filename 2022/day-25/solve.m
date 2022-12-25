
E = cell2mat( convertStringsToChars( pad( readlines( 'input.txt', 'EmptyLineRule', 'skip' ), 'left', '0' ) ) );

K( '=-012' ) = [ -2 -1 0 1 2 ];
S = sum( K(E) * 5.^(size(E,2)-1:-1:0)' );

T = '012=-0';
Z = [];
r = false;
while S > 0 || r
  v = mod( S, 5 ) + r;
  Z = [ T(v+1) Z ]; %#ok<AGROW>
  r = v >= 3;
  S = floor( S/5 );
end

disp( Z )
