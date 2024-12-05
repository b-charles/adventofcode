function M = order( C, L )

test = @(a,b) ismember( [ a, b ], C, 'rows' );

M = L(1);
for r = L(2:end)
  if test( r, M(1) )
    M = [ r M ]; %#ok<AGROW>
  elseif test( M(end), r )
    M = [ M r ]; %#ok<AGROW>
  else
    for idx = 1:length(M)-1
      if test( M(idx), r ) && test( r, M(idx+1) )
        M = [ M(1:idx) r M(idx+1:end) ];
        break
      end
    end
  end
end

end