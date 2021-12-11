
M = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) ) - '0';

t = 0;
for i = 1:100
    [ M, F ] = step(M);
    t = t + sum( F(:) );
end

disp( t );

%%

i = 100;
while any( ~F(:) )
    [ M, F ] = step( M );
    i = i + 1;
end

disp( i );

%%

function [ M, F ] = step( M )

M = M + 1;
T = M >= 10;
F = T;
while any(T(:))
    M = M + conv2( T, ones(3), 'same' );
    T = M >= 10 & ~F;
    F = F | T;
end

M(F) = 0;

end