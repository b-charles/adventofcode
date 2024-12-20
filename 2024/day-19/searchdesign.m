function [ n, C ] = searchdesign( P, design, C )

if isempty( design )
  n = 1;
  return
end

if isfield( C, design )
  n = C.(design);
  return
end

n = 0;
for i = 1:length(P)
  if startsWith( design, P{i} )
    [ s, C ] = searchdesign( P, design( length(P{i})+1:end ), C );
    n = n + s;
  end
end

C.(design) = n;
