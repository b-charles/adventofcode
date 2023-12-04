
N = str2double( extract( readlines( 'input.txt', 'EmptyLineRule', 'skip' ), digitsPattern ) );
W = table2array( rowfun( @(w,n) sum( ismember(w,n) ), table(N(:,2:11), N(:,12:end)) ) );

sum( floor( 2.^( W - 1 ) ) )

%%

T = ones(size(W));
for i = 1:length(T)
  T(i+(1:W(i))) = T(i+(1:W(i))) + T(i);
end

sum( T )
