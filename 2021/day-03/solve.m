
bin2dec = @(V) V*( 2.^((size(V,2)-1):-1:0)' );
most = @(V) mean(V,1) >= 0.5;

D = char( readlines( 'input.txt', 'EmptyLineRule','skip' ) ) == '1';

M = most(D);
bin2dec(M) * bin2dec(~M)

%%

L = D; c = 1;
while size( L, 1 ) > 1
    L = L( L(:,c) == most( L(:,c) ), : );
    c = c + 1;
end

O = D; c = 1;
while size( O, 1 ) > 1
    O = O( O(:,c) ~= most( O(:,c) ), : );
    c = c + 1;
end

bin2dec(L) * bin2dec(O)