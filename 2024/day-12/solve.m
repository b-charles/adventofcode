
M = char( readlines( 'input.txt', 'EmptyLineRule', 'skip' ) );
S = size( M );

W = zeros( S );
while any( W == 0, 'all' )

  w = find( W == 0, 1, 'first' );

  E = M == M(w);

  Z = false( S );
  Z(w) = true;

  Zn = ( conv2( Z, [ 0 1 0 ; 1 1 1 ; 0 1 0 ], 'same' ) ~= 0 ) & E;
  while any( Zn ~= Z, 'all' )
    Z = Zn;
    Zn = ( conv2( Z, [ 0 1 0 ; 1 1 1 ; 0 1 0 ], 'same' ) ~= 0 ) & E;
  end

  W(Z) = max( W(:) ) + 1;

end

price = 0;
for w = unique( W(:) )'
  Z = W == w;
  price = price + sum( Z, 'all' )*( ...
    sum( diffup( Z ), 'all' ) + ...
    sum( diffdown( Z ), 'all' ) + ...
    sum( diffright( Z ), 'all' ) + ...
    sum( diffleft( Z ), 'all' ) );
end

price

%%

price = 0;
for w = unique( W(:) )'
  Z = W == w;
  price = price + sum( Z, 'all' )*( ...
    sum( diffright( diffup( Z ) ), 'all' ) + ...
    sum( diffleft( diffdown( Z ) ), 'all' ) + ...
    sum( diffup( diffright( Z ) ), 'all' ) + ...
    sum( diffdown( diffleft( Z ) ), 'all' ) );
end

price

%%

function X = diffup( X )
X = X & [ true( 1, size(X,2) ) ; ~X(1:end-1,:) ];
end
function X = diffdown( X )
X = X & [ ~X(2:end,:) ; true( 1, size(X,2) ) ];
end
function X = diffright( X )
X = X & [ ~X(:,2:end) true( size(X,1), 1 ) ];
end
function X = diffleft( X )
X = X & [ true( size(X,1), 1 ) ~X(:,1:end-1) ];
end