
[ M, F ] = readin( 'input.txt' );

M = fold( M, F(1).axe, F(1).val );
sum( M(:) )

%%

for f = F(2:end)
  M = fold( M, f.axe, f.val );
end

pcolor( [ ~M; false(1,size(M,2)) ] )
colormap( gray(2) )
axis ij
axis equal

%%

function M = fold( M, axe, val )
  if axe == 'y'
    M = fold( M', 'x', val )';
  else
    P = M(:,end:-1:val+1);
    M(:,val:end) = [];
    M = M | P;
  end
end
