function R = gardenmap( M, I )

R = [];
for l = 1:size(I, 1)

  S = I(l,:);
  while ~isempty(S)

    [ s, S ] = deal( S(1,:), S(2:end,:) );
    for k = 1:size( M, 1 )

      if s(1) < M(k,2) && M(k,2) <= s(1)+s(2)-1
        S(end+1,:) = [ M(k,2), s(1)+s(2)-M(k,2) ];
        s = [ s(1), M(k,2)-s(1)+1 ];
      end

      if s(1) <= M(k,2)+M(k,3)-1 && M(k,2)+M(k,3) < s(1)+s(2)
        S(end+1,:) = [ M(k,2)+M(k,3) s(1)+s(2)-M(k,2)-M(k,3) ];
        s = [ s(1), M(k,2)+M(k,3)-s(1) ];
      end

    end

    R(end+1,:) = s; %#ok<*AGROW>

  end

end

for k = 1:size(R, 1)

  t = R(k,:);

  l = find( M(:,2) <= t(1) & (t(1)+t(2)) <= M(:,2)+M(:,3) );
  if ~isempty( l )
    R(k,:) = [ M(l,1)+t(1)-M(l,2), t(2) ];
  end

end
