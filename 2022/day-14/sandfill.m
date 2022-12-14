function nb = sandfill( R, S, stop )

  function P = fall( R, P )
    while P(1) < size(R,1)
      N = [ P+[1 0] ; P+[1 -1] ; P+[1 1] ];
      F = find( ~R( sub2ind( size(R), N(:,1), N(:,2) ) ), 1 );
      if isempty(F)
        return
      else
        P = N(F,:);
      end
    end
  end

F = fall( R, S );
nb = 1;
while ~stop( F )
  R(F(1), F(2)) = true;
  F = fall( R, S );
  nb = nb + 1;
end

end
