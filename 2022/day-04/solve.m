
Z = readmatrix( 'input.txt', 'Delimiter', { '-', ',' } );

sum( ( Z(:,1) <= Z(:,3) & Z(:,4) <= Z(:,2) ) | ( Z(:,3) <= Z(:,1) & Z(:,2) <= Z(:,4) ) )

%%

sum( Z(:,1) <= Z(:,4) & Z(:,2) >= Z(:,3) )
