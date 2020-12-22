
% [ R, M ] = readin( 'demo1.in' );
% [ R, M ] = readin( 'demo2.in' );
[ R, M ] = readin( 'data.in' );

C = cellfun( @(m)R{1}.check(m,R,[]), M );

disp( sum( C ) );

%%

R{8+1} = RuleLoop( 42 );
R{11+1} = RuleDuo( 42, 31 );

C = cellfun( @(m)R{1}.check(m,R,[]), M );

disp( sum( C ) );

%%

% 250
% 359
