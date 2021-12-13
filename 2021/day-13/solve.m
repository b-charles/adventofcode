
[ M, F ] = readin( 'input.txt' );

M = fold( M, F(1) );
sum( M(:) )

%%²

for f = F(2:end)
  M = fold( M, f );
end

pcolor( [ ~M; true(1,size(M,2)) ] )
colormap( gray(2) )
axis ij
axis equal

%%

function M = fold( M, f )

sm = size( M );

if f.axe == 'x'

  P = M(:,end:-1:f.val+1);
  M(:,f.val:end) = [];
  Mpad = false( sm(1), max( sm(2) - 2*f.val + 1, 0 ) );
  Ppad = false( sm(1), max( 2*f.val - sm(2) - 1, 0 ) );
  M = [ Mpad M ] | [ Ppad P ];

else

  P = M(end:-1:f.val+1,:);
  M(f.val:end,:) = [];
  Mpad = false( max( sm(1) - 2*f.val + 1, 0 ), sm(2) );
  Ppad = false( max( 2*f.val - sm(1) - 1, 0 ), sm(2) );
  M = [ Mpad ; M ] | [ Ppad ; P ];

end

end