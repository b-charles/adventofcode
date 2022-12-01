
R = readcell( 'input', 'Delimiter', '\n', 'LineEnding', '\n\n' );
C = sort( arrayfun( @(i)sum([R{i,:}], 'omitnan'), 1:size(R,1) ), 'descend' );

C(1)

%%

sum( C(1:3) )
