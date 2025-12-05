
[ R, I ] = readin( 'input.txt' );

C = compact( R );

M = repmat( I', size( C, 1 ), 1 );
sum( any( C(:,1) <= M & M <= C(:,2), 1 ) )

%%

uint64( sum( diff( C, [], 2 ) ) + size( C, 1 ) )

%%

function R = compact( R )

s = 0;
while s ~= size( R, 1 )

  s = size( R, 1 );

  i = 1;
  while i <= size(R,1)

    j = i + 1;
    while j <= size(R,1)

      if R(i,1) <= R(j,1) && R(j,2) <= R(i,2) % [ i- [ j ] -i ]
        R(j,:) = [];
      elseif R(j,1) <= R(i,1) && R(i,2) <= R(j,2) % [ j- [ i ] -j ]
        R(i,:) = R(j,:);
        R(j,:) = [];
      elseif R(i,1) <= R(j,1) && R(j,1) <= R(i,2) % [ i- [ j- -i ] -j ]
        R(i,:) = [ R(i,1) R(j,2) ];
        R(j,:) = [];
      elseif R(j,1) <= R(i,1) && R(i,1) <= R(j,2) % [ j- [ i- -j ] -i ]
        R(i,:) = [ R(j,1) R(i,2) ];
        R(j,:) = [];
      else
        j = j + 1;
      end

    end

    i = i + 1;

  end

end

end
