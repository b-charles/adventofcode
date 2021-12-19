function C = readin( file )

M = readmatrix( file );

I = [ 0 find(any(isnan(M),2))' size(M,1)+1 ];

C = cell( 1, length(I)-1 );

for i = 1:length(I)-1
  C{i} = M( I(i)+1:I(i+1)-1, : );
end
