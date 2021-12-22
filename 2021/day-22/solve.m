
[ S, C ] = readin( 'input.txt' );
C( :, [2 4 6] ) = C( :, [2 4 6] ) + 1;

I = all( -50<=C & C<=50, 2 );
count( S(I), C(I,:) )

%%

uint64( count( S, C ) )

%%

function s = super( A, B )
s = A(:,1) < B(:,2) & B(:,1) < A(:,2) & ...
  A(:,3) < B(:,4) & B(:,3) < A(:,4) & ...
  A(:,5) < B(:,6) & B(:,5) < A(:,6);
end

function c = count( S, C )

B = zeros( 0, 6 );

for i = 1:length(S)
  j = 1;
  while j <= size(B,1)
    if super( B(j,:), C(i,:) )

      X = sort( [ B(j,1) B(j,2) C(i,1) C(i,2) ] );
      Y = sort( [ B(j,3) B(j,4) C(i,3) C(i,4) ] );
      Z = sort( [ B(j,5) B(j,6) C(i,5) C(i,6) ] );

      F = [ ...
        X(1) X(2) Y(1) Y(2) Z(1) Z(2) ; X(2) X(3) Y(1) Y(2) Z(1) Z(2) ; X(3) X(4) Y(1) Y(2) Z(1) Z(2) ; ...
        X(1) X(2) Y(2) Y(3) Z(1) Z(2) ; X(2) X(3) Y(2) Y(3) Z(1) Z(2) ; X(3) X(4) Y(2) Y(3) Z(1) Z(2) ; ...
        X(1) X(2) Y(3) Y(4) Z(1) Z(2) ; X(2) X(3) Y(3) Y(4) Z(1) Z(2) ; X(3) X(4) Y(3) Y(4) Z(1) Z(2) ; ...
        X(1) X(2) Y(1) Y(2) Z(2) Z(3) ; X(2) X(3) Y(1) Y(2) Z(2) Z(3) ; X(3) X(4) Y(1) Y(2) Z(2) Z(3) ; ...
        X(1) X(2) Y(2) Y(3) Z(2) Z(3) ; X(2) X(3) Y(2) Y(3) Z(2) Z(3) ; X(3) X(4) Y(2) Y(3) Z(2) Z(3) ; ...
        X(1) X(2) Y(3) Y(4) Z(2) Z(3) ; X(2) X(3) Y(3) Y(4) Z(2) Z(3) ; X(3) X(4) Y(3) Y(4) Z(2) Z(3) ; ...
        X(1) X(2) Y(1) Y(2) Z(3) Z(4) ; X(2) X(3) Y(1) Y(2) Z(3) Z(4) ; X(3) X(4) Y(1) Y(2) Z(3) Z(4) ; ...
        X(1) X(2) Y(2) Y(3) Z(3) Z(4) ; X(2) X(3) Y(2) Y(3) Z(3) Z(4) ; X(3) X(4) Y(2) Y(3) Z(3) Z(4) ; ...
        X(1) X(2) Y(3) Y(4) Z(3) Z(4) ; X(2) X(3) Y(3) Y(4) Z(3) Z(4) ; X(3) X(4) Y(3) Y(4) Z(3) Z(4) ];

      F( ~super(F,B(j,:)) | super(F,C(i,:)), : ) = [];

      B = [ B(1:j-1,:) ; F ; B(j+1:end,:) ];
      j = j + size(F,1);

    else

      j = j+1;

    end
  end
  if S(i)
    B = [ B ; C(i,:) ]; %#ok<AGROW>
  end
end

c = sum( (B(:,2)-B(:,1)) .* (B(:,4)-B(:,3)) .* (B(:,6)-B(:,5)) );

end

