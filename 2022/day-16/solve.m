
[ N, R, T ] = readin( 'input.txt' );

O = allValveTimes( R, T, 30 );
max( O*R' )

%%

O = allValveTimes( R, T, 26 );
E = arrayfun( @(i) max( O( all( O( :, O(i,:) > 0 ) == 0, 2 ), : )*R' ), 1:size(O,1) )';
max( O*R' + E )

%%

function O = allValveTimes( R, T, tmax )

n = length(R);

A = false( n, n, n );
A(:,:,1) = eye(n) > 0;
for i = 2:n
  A(:,:,i) = A(:,:,i-1)*T > 0;
end
[ I, J ] = meshgrid( 1:n );
L = arrayfun( @(i,j)find(A(i,j,:),1), I, J ) - 1;

  function O = generate( O, c, t )
    D = find( (O==0) & (R>0) & ( L(:,c) <= t-2 )' );
    if ~isempty( D )
      Z = cell( length(D)+1, 1 );
      for d = 1:length(D)
        N = O;
        N(D(d)) = t - L(D(d), c) - 1;
        Z{d} = generate( N, D(d), N(D(d)) );
      end
      Z{end} = O;
      O = cell2mat( Z );
    end
  end

O = generate( zeros( 1, n ), 1, tmax );

end