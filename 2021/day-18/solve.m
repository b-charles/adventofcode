
P = readin( 'input.txt' );

sum( P ).mag()

%%

V = nchoosek( 1:length(P), 2 );
R = zeros( size(V,1), 1 );
for i = 1:size(V,1)
  S = P(V(i,1)) + P(V(i,2));
  R(i) = S.mag();
end

max(R)
