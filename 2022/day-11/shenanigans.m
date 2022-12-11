function r = shenanigans( I, M, rounds, stress )

n = length(M);
A = zeros(1, n);

modstress = prod([ M.div ]);

for r = 1:rounds
  for num = 1:n
    items = I{num};
    m = M(num);
    A(num) = A(num) + length(items);
    v = mod( floor( m.op( items ) / stress ), modstress );
    t = mod( v, m.div ) == 0;
    I{num} = zeros(1,0);
    I{m.itrue} = [ I{m.itrue} v(t) ];
    I{m.ifalse} = [ I{m.ifalse} v(~t) ];
  end
end

A = sort( A, 'descend' );
r = uint64( A(1) * A(2) );
